//
//  BookingVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class BookingVC: UIViewController{
    private var previewIndex = [IndexPath(), IndexPath()]
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
        reloadColorButton(target: false)
        setFirstData()
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func reloadColorButton(target: Bool){
        if (target){
            changeTableField.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            changeTableField.isUserInteractionEnabled = true
        }else{
            changeTableField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
            changeTableField.isUserInteractionEnabled = false
        }
    }
    
    private func setFirstData(){
        var countDay = 7
        
        for item in 0..<countDay{
            let day = DateCVC(numberDay: item)
            if (item == 0){
                if !hoursWork.isBookingCloseToday(day: day.getDate()){
                    day.itIsToday()
                    arrayDay.append(day)
                }else{
                    countDay += 1
                }
            }else{
                arrayDay.append(day)
            }
        }
        //указываем первоночальные настройки, что выбран сегоднешней день и самое ближайшее время
        // доступное для брони
        arrayDay[0].check = true
        previewIndex[0] = IndexPath(indexes: [0, 0])
        hoursWork.changeDay(day: String(arrayDay[0].text.split(separator: "\n")[1]),
                            today: true)
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
        previewIndex[1] = IndexPath()
        hoursWork.setIndexDuration(index: 0)
        reloadColorButton(target: false)
        TimeDurationCollectionView.reloadData()
    }
    
    //Перерасчет времени куда можно забронить
    private func calcAndSetTime(){
        self.hoursWork.calcDurationTime()
        self.setDataHours()
        self.changeTimeSting.setTitle(self.hoursWork.getSelectTime(), for: .normal)
    }
    
    @IBAction func changeTime(_ sender: UIButton) {
        hoursWork.selectIndex(index: 0)
        let editRadiusAlert = UIAlertController(title: "Выберите время", message: "", preferredStyle: UIAlertController.Style.alert)
        print("alert", editRadiusAlert.view.frame.height)
        print("alert", self.view.frame.height)
        let pickeViewFrame: CGRect = CGRect(x: 5, y: 10, width: 250, height: editRadiusAlert.view.frame.height/3)
        let pickerViewRadius: UIPickerView = UIPickerView(frame: pickeViewFrame)
        pickerViewRadius.delegate = self
        pickerViewRadius.dataSource = self
        editRadiusAlert.view.addSubview(pickerViewRadius)
        editRadiusAlert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default,handler:{ (UIAlertAction) in
            self.calcAndSetTime()
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            /*if (self.arrayHour.count > 0){
                self.changeTimeSting.titleLabel?.text = self.hoursWork.getSelectTime()
            }*/
        }))
        editRadiusAlert.view.addConstraint(NSLayoutConstraint(item: editRadiusAlert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.5))
        self.present(editRadiusAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func changeTable(_ sender: UIButton) {
        let time = hoursWork.getDataToServer(day: arrayDay[previewIndex[0].item].getDate())
        if (time.timeFrom.isEmpty || time.timeTo.isEmpty){
            reloadColorButton(target: false)
            return
        }
        let storyboard = UIStoryboard(name: "SelectTableScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectTableVC") as! SelectTableVC
        vc.date = time.dateFrom
        vc.date_to = time.dateTo
        vc.time_to = time.timeTo
        vc.time_from = time.timeFrom
        navigationController?.pushViewController(vc, animated: true)
    }
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
                hoursWork.selectIndex(index: 0)
            }
            reloadColorButton(target: false)
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
            reloadColorButton(target: true)
            TimeDurationCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == DateCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! Cell
            print(indexPath.item, arrayDay.count)
            if (arrayDay.count > 0){
                cell.setDate(dateCVC: arrayDay[indexPath.item])
                calcAndSetTime()
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
