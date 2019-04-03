//
//  BookingVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class BookingVC: UIViewController{
    private var previewIndex = [IndexPath(indexes: [0, 0]), IndexPath(indexes: [0, 0])]
    private var arrayDay: [DateCVC] = []
    private var arrayHour: [DateCVC] = []
    private var arrayHourOfDay: [String] = []
    private var hoursWork = HoursWork()
    
    @IBOutlet weak var DateCollectionView: UICollectionView!
    @IBOutlet weak var TimeDurationCollectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var changeTimeSting: UIButton!
    @IBOutlet weak var changeTableField: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        changeTimeSting.layer.borderWidth = 3.0
        changeTimeSting.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        changeTimeSting.layer.cornerRadius = 4
        firstStart()
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func firstStart(){
        if !(DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(status: 100, protocol: self), animated: true, completion: nil)
        }else{
            DataLoader.shared().getTimetable(){ result, error  in
                if (error?.code == 200){
                    self.hoursWork.responseTimetable = result
                    self.setDataDay()
                }else{
                    self.present(Alert.shared().couldServerDown(status: 100, protocol: self), animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setDataDay(){
        var countDay = 7
        var item = 0
        //for item in 0..<countDay{
        while item < countDay {
            let day = DateCVC(numberDay: item)
            if (item == 0){
                if !hoursWork.isBookingCloseToday(day: day.getDay()){
                    day.reloadToday()
                    arrayDay.append(day)
                }else{
                    countDay += 1
                }
            }else{
                arrayDay.append(day)
            }
            print("setFirstData", day.date)
            item += 1
        }
        //указываем первоночальные настройки, что выбран сегоднешней день и самое ближайшее время
        // доступное для брони
        arrayDay[0].reload()
        hoursWork.changeDay(day: String(arrayDay[0].text.split(separator: "\n")[1]),
                            today: arrayDay[0].checkToday())
        hoursWork.selectIndex(index: 0)
        calcAndSetTime()
        DateCollectionView.reloadData()
    }
    
    private func setDataHours(){
        arrayHour.removeAll()
        self.TimeDurationCollectionView.reloadData()
        for item in 0..<hoursWork.getCountDurationTime(){
            let hour = DateCVC(text: hoursWork.getItemDurationTime(index: item) + "\nчаса")
            arrayHour.append(hour)
        }
        
        if (hoursWork.getCountDurationTime() < previewIndex[1].item || previewIndex[1].item == 0){
            if (arrayHour.count > 0){
                previewIndex[1] = IndexPath(indexes: [0, 0])
                arrayHour[0].reload()
                hoursWork.setIndexDuration(index: 0)
            }
        }else{
            arrayHour[previewIndex[1].item].reload()
        }
        TimeDurationCollectionView.reloadData()
    }
    
    //Перерасчет времени куда можно забронить
    private func calcAndSetTime(){
        hoursWork.calcDurationTime()
        setDataHours()
        changeTimeSting.setTitle(self.hoursWork.getSelectTime(), for: .normal)
    }
    
    @IBAction func changeTime(_ sender: UIButton) {
        hoursWork.selectIndex(index: 0)
        self.present(Alert.shared().pickerAlert(protocol: self, delegate: self, dataSource: self, height: self.view.frame.height), animated: true, completion: nil)
    }
    
    
    @IBAction func changeTable(_ sender: UIButton) {
        let time = hoursWork.getDataToServer(day: arrayDay[previewIndex[0].item].date)
        if (time.timeFrom.isEmpty || time.timeTo.isEmpty){
            return
        }
        if (!Reachability.isConnectedToNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            var date = RequestPostEmptyPlaces()
            date.date = time.dateFrom
            date.date_to = time.dateTo
            date.time_to = time.timeTo
            date.time_from = time.timeFrom
            downloadTable(date: date)
        }
    }
    
    private func downloadTable(date: RequestPostEmptyPlaces){
        if (!Reachability.isConnectedToNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            DataLoader.shared().getEmptyTables(data: date){ result, error in
                if error?.code == 200 {
                    if result.data.count == 0 {
                        self.present(Alert.shared().tableAraBusy(protocol: self), animated: true, completion: nil)
                    }else{
                        let storyboard = UIStoryboard(name: "SelectTableScreen", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "SelectTableVC") as! SelectTableVC
                        vc.date = date.date
                        vc.date_to = date.date_to
                        vc.time_to = date.time_to
                        vc.time_from = date.time_from
                        vc.tables = result
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
                }
            }
        }
    }
}

extension BookingVC: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        if (status == 100){
            firstStart()
        }else{
            calcAndSetTime()
        }
    }
    
    func clickButtonCanсel(status: Int) {}
}

//расширение для методов CollectionView
extension BookingVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == DateCollectionView{
            return 7
        } else {
            return hoursWork.getCountDurationTime()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == DateCollectionView{
            if (arrayDay.count > 0){
                //обновление модели
                arrayDay[indexPath.item].reload()
                if (!previewIndex[0].isEmpty){
                    arrayDay[previewIndex[0].item].reload()
                    print(previewIndex[0])
                }
                //установка первоночальных значений для выбора времени
                hoursWork.changeDay(day: String(arrayDay[indexPath.item].text.split(separator: "\n")[1]),
                                    today: arrayDay[indexPath.item].checkToday())
                //hoursWork.selectIndex(index: 0)
                calcAndSetTime()
                //imeDurationCollectionView.reloadData()
            }
            previewIndex[0] = indexPath
            DateCollectionView.reloadData()
        } else {
            if (arrayHour.count > 0){
                arrayHour[indexPath.item].reload()
                hoursWork.setIndexDuration(index: indexPath.item)
                if (!previewIndex[1].isEmpty){
                    arrayHour[previewIndex[1].item].reload()
                }
            }
            previewIndex[1] = indexPath
            TimeDurationCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == DateCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! Cell
            print(indexPath.item, arrayDay.count)
            if (arrayDay.count > 0){
                cell.setDate(dateCVC: arrayDay[indexPath.item])
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DurationCell", for: indexPath) as! Cell
            if (arrayHour.count > 0){
                cell.setDate(dateCVC: arrayHour[indexPath.item])
            }
            return cell
        }
    }
}


//расширение для методов picker
extension BookingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hoursWork.getCountTime()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hoursWork.getItemTime(item: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hoursWork.selectIndex(index: row)
    }
}
