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
        }
    }
    
    private var first: Bool = true
    
    @IBOutlet weak var DateCollectionView: UICollectionView!
    @IBOutlet weak var TimeDurationCollectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var changeTimeSting: UIButton!
    
    @IBAction func changeTime(_ sender: UIButton) {
        datePicker.isHidden = picker
        if !picker {
            picker = true
        } else {
            picker = false
        }
        
       
    }
    @IBAction func changeTable(_ sender: UIButton) {
    }
    
    var previewIndex = [IndexPath(), IndexPath()]
    var duration = ["2", "2.5", "3", "3.5", "4"]
    
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
            if (!previewIndex[0].isEmpty){
                let previewCell = collectionView.cellForItem(at: previewIndex[0]) as? DateCVC
                if (previewCell != nil){
                    previewCell!.reloadData()
                }
            }
            previewIndex[0] = indexPath
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! TimeDurationCVC
            cell.reloadData()
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
            let ndate = Date()
            let date = format.string(from: ndate)
            cell.date.text = date
            //cell.reloadData()
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
        
        let min = dateFormatter.date(from: "9:00")      //createing min time
        let max = dateFormatter.date(from: "21:00") //creating max time
        datePicker.minimumDate = min  //setting min time to picker
        datePicker.maximumDate = max  //setting max time to picker
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    



}
