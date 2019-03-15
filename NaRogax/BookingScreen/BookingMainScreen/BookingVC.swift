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
    
    var previewIndex = [IndexPath(), IndexPath()]
    var duration = ["2", "2.5", "3", "3.5", "4"]
    var durationTime = ["2:00", "2:30", "3:00", "3:30", "4:00"]
    
    @IBOutlet weak var DateCollectionView: UICollectionView!
    @IBOutlet weak var TimeDurationCollectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var changeTimeSting: UIButton!
    
    @IBAction func changeTime(_ sender: UIButton) {
        if !picker{
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
        picker = !picker
        
    }
    
    @IBOutlet weak var changeTableField: UIButton!
    
    @IBAction func changeTable(_ sender: UIButton) {
        if date != "" && timeTo != "" && timeFrom != "" {
            
            var newDate = date
            var newTimeTo = timeTo
            var newTimeFrom = timeFrom
            var newDateTo = date
            
            var allH = 0
            var allM = 0
            
            var someDate = Date()
            let dateFormatter = DateFormatter()
            let calendar = Calendar.current
            
            dateFormatter.dateFormat = "HH:mm"
            someDate = dateFormatter.date(from: newTimeFrom)!
            dateFormatter.dateFormat = "HH:mm:ss"
            newTimeFrom = dateFormatter.string(from: someDate)
            
            dateFormatter.dateFormat = "HHH:mm:ss"
            someDate = dateFormatter.date(from: newTimeFrom)!
            dateFormatter.dateFormat = "H"
            var timeToH = dateFormatter.string(from: someDate)
            dateFormatter.dateFormat = "mm"
            var timeToM = dateFormatter.string(from: someDate)
            
            allH += Int(timeToH)!
            allM += Int(timeToM)!
            
            dateFormatter.dateFormat = "H:mm"
            someDate = dateFormatter.date(from: newTimeTo)!
            dateFormatter.dateFormat = "H"
            timeToH = dateFormatter.string(from: someDate)
            dateFormatter.dateFormat = "mm"
            timeToM = dateFormatter.string(from: someDate)
            
            allH += Int(timeToH)!
            allM += Int(timeToM)!
            
            dateFormatter.dateFormat = "HH:mm:ss"
            someDate = dateFormatter.date(from: newTimeFrom)!
            someDate = calendar.date(byAdding: .hour, value: Int(timeToH)!, to: someDate)!
            someDate = calendar.date(byAdding: .minute, value: Int(timeToM)!, to: someDate)!
            
            newTimeTo = dateFormatter.string(from: someDate)
            
            dateFormatter.dateFormat = "dd\nEE"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            someDate = dateFormatter.date(from: newDate)!
            dateFormatter.dateFormat = "dd"
            let dateDay = dateFormatter.string(from: someDate)
            
            someDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
            someDate = calendar.date(byAdding: .day, value: Int(dateDay)! - 1, to: someDate)!
            dateFormatter.dateFormat = "YYYY-MM-dd"
            newDate = dateFormatter.string(for: someDate)!
            
            someDate = calendar.date(byAdding: .hour, value: allH, to: someDate)!
            someDate = calendar.date(byAdding: .minute, value: allM, to: someDate)!
            newDateTo = dateFormatter.string(for: someDate)!
            
            
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
            return 5
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == DateCollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as! DateCVC
            cell.reloadSelected()
            date = cell.date.text!
            
            //Сброс таимпикера
            changeTimeSting.setTitle("Нажмите", for: .normal)
            timeFrom = ""
            
            let format = DateFormatter()
            let calendar = Calendar.current
            
            format.dateFormat = "dd\nEE"
            format.locale = Locale(identifier: "ru_RU")
            var someDate = format.date(from: date)
            
            let DateToday = calendar.dateComponents([.year, .month], from: Date())
            let DayToday = calendar.dateComponents([.day], from: someDate!)
            
            someDate = calendar.date(from: DateToday)
            someDate = calendar.date(byAdding: DayToday, to: someDate!)
            someDate = calendar.date(byAdding: .day, value: -1, to: someDate!)
            
            format.dateFormat = "EE"
            let currentDay = format.string(from: someDate!)
           // print(currentDay)
            
            if timeTable.count != 0{
                for week_day in timeTable[0].data {
                    if currentDay == week_day.week_day{
                        format.dateFormat = "HH:mm:ss"
                        var min = format.date(from: week_day.time_from)
                        var max = format.date(from: week_day.time_to)
    
                        let TimeToday = calendar.dateComponents([.year, .month, .day], from: Date())
                        let TimeFrom =  calendar.dateComponents([.hour, .minute, .second], from: min!)
                        let TimeTo = calendar.dateComponents([.hour, .minute, .second], from: max!)
                        
                        min = calendar.date(from: TimeToday)
                        max = calendar.date(from: TimeToday)
                        min = calendar.date(byAdding: TimeFrom, to: min!)
                        max = calendar.date(byAdding: TimeTo, to: max!)
                        
                        if min! > max! {
                            max = calendar.date(byAdding: .day, value: 1, to: max!)
                        }
                        
                        format.dateFormat = "YYYY-MM-dd HH:mm:ss"
                        datePicker.minimumDate = min
                        datePicker.maximumDate = max
                        datePicker.reloadInputViews()
                        
//                        let checkMin = format.string(from: datePicker.minimumDate!)
//                        let checkMax = format.string(from: datePicker.maximumDate!)
//
//                        print(checkMin)
//                        print(checkMax)
                    }
                }
            }
            
            if (!previewIndex[0].isEmpty){
                let previewCell = collectionView.cellForItem(at: previewIndex[0]) as? DateCVC
                if (previewCell != nil){
                    previewCell!.reloadSelected()
                }
            }
            
            previewIndex[0] = indexPath
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! TimeDurationCVC
            cell.reloadSelected()
            timeTo = durationTime[indexPath.row]
            if (!previewIndex[1].isEmpty){
                let previewCell = collectionView.cellForItem(at: previewIndex[1]) as? TimeDurationCVC
                if (previewCell != nil){
                    previewCell!.reloadSelected()
                }
            }
            previewIndex[1] = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == DateCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCVC
            let format = DateFormatter()
            format.dateFormat = "dd\nEE"
            format.locale = Locale(identifier: "ru_RU")
            let ndate = Calendar.current.date(byAdding: .day, value: indexPath.last ?? 0, to: Date())!
            let date = format.string(from: ndate)
            cell.date.text = date
            cell.date.initial()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DurationCell", for: indexPath) as! TimeDurationCVC
            cell.timeDuration.text = duration[indexPath.row] + "\nчаса"
            return cell
        }
    }
    
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
    
}
