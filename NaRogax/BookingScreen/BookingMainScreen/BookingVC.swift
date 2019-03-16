//
//  BookingVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class BookingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var picker = false{
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            changeTimeSting.setTitle(dateFormatter.string(for: datePicker.date), for: .normal)
            timeFrom = dateFormatter.string(for: datePicker.date)!
        }
    }
    
    private var first: Bool = true
    
    var date = ""
    var timeFrom = ""
    var timeTo = ""
    var timeTable:[Timetable] = []
    
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
        changeTimeSting.layer.cornerRadius = 5
        
        let dataLoader = DataLoader()
        dataLoader.getTimetable{ items in self.timeTable.append(contentsOf: items)
            self.datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            var dateComponent = DateComponents()
            dateComponent.hour = Calendar.current.component(.hour, from: Date())
            self.datePicker.date = Calendar.current.date(from: dateComponent)!
            self.datePicker.date = Calendar.current.date(byAdding: .hour, value: 3, to: self.datePicker.date)!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setDataArray()
        DateCollectionView.reloadData()
        TimeDurationCollectionView.reloadData()
    }
    
    private func setDataArray(){
        for item in 0..<7{
            let day = DateCVC(numberDay: item)
            arrayDay.append(day)
        }
    }
    
    private func setDataHours(){
        arrayHour.removeAll()
        self.TimeDurationCollectionView.reloadData()
        for item in 0..<hoursWork.getCountDurationTime(){
            let hour = DateCVC(text: hoursWork.getItemDurationTime(index: item) + "\nчасов")
            arrayHour.append(hour)
        }
    }
    
    @IBAction func changeTime(_ sender: UIButton) {
        hoursWork.selectIndex(index: 0)
        let editRadiusAlert = UIAlertController(title: "Выберите время", message: "", preferredStyle: UIAlertController.Style.alert)
        let pickeViewFrame: CGRect = CGRect(x: 0, y: 0, width: 250, height: 300)
        let pickerViewRadius: UIPickerView = UIPickerView(frame: pickeViewFrame)
        pickerViewRadius.delegate = self
        pickerViewRadius.dataSource = self
        editRadiusAlert.view.addSubview(pickerViewRadius)
        editRadiusAlert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default,handler:{ (UIAlertAction) in
            self.changeTimeSting.titleLabel?.text = self.hoursWork.getSelectTime()
            self.hoursWork.calcDurationTime()
            self.setDataHours()
            self.TimeDurationCollectionView.reloadData()
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            if (self.arrayHour.count > 0){
                self.changeTimeSting.titleLabel?.text = self.hoursWork.getSelectTime()
            }
        }))
        editRadiusAlert.view.addConstraint(NSLayoutConstraint(item: editRadiusAlert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.5))
        self.present(editRadiusAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func changeTable(_ sender: UIButton) {
        if date != "" && timeTo != "" && timeFrom != "" {
            
            var newDate = date
            var newTimeTo = timeTo
            var newTimeFrom = timeFrom
            var newDateTo = date
            
            
            let storyboard = UIStoryboard(name: "SelectTableScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectTableVC") as! SelectTableVC
            
            vc.date = newDate
            vc.time_to = newTimeTo
            vc.time_from = newTimeFrom
            vc.date_to = newDateTo
            
            newDate = date
            newTimeTo = timeTo
            newTimeFrom = timeFrom
            newDateTo = date
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
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
                //print(arrayDay[indexPath.item].text.split(separator: "\n")[1])
                hoursWork.changeDay(day: String(arrayDay[indexPath.item].text.split(separator: "\n")[1]),
                                    today: indexPath.item == 0)
                arrayDay[indexPath.item].reload()
                if (!previewIndex[0].isEmpty){
                    arrayDay[previewIndex[0].item].reload()
                }
            }
            print("collectionView", indexPath, arrayDay.count)
            previewIndex[0] = indexPath
            DateCollectionView.reloadData()
        } else {
            if (arrayHour.count > 0){
                arrayHour[indexPath.item].reload()
                if (!previewIndex[1].isEmpty){
                    arrayHour[previewIndex[1].item].reload()
                }
            }
            timeTo = hoursWork.getItemDurationTime(index: indexPath.row)
            TimeDurationCollectionView.reloadData()
            previewIndex[1] = indexPath
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == DateCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! Cell
            //print(indexPath.item, arrayDay.count)
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
