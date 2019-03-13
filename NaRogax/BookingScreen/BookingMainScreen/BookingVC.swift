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
            
            dateFormatter.dateFormat = "HH:mm:ss"
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
            
            print(newDate)
            print(newDateTo)
            print(newTimeTo)
            print(newTimeFrom)
            
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
            cell.reloadData()
            date = cell.date.text!
            if (!previewIndex[0].isEmpty){
                let previewCell = collectionView.cellForItem(at: previewIndex[0]) as? DateCVC
                if (previewCell != nil){
                    previewCell!.reloadData()
                }
            }
            previewIndex[0] = indexPath
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! TimeDurationCVC
            cell.reloadData()
            timeTo = durationTime[indexPath.row]
            if (!previewIndex[1].isEmpty){
                let previewCell = collectionView.cellForItem(at: previewIndex[1]) as? TimeDurationCVC
                if (previewCell != nil){
                    previewCell!.reloadData()
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

        let min = dateFormatter.date(from: "9:00")      //createing min time
        let max = dateFormatter.date(from: "21:00") //creating max time
        datePicker.minimumDate = min  //setting min time to picker
        datePicker.maximumDate = max  //setting max time to picker
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
}
