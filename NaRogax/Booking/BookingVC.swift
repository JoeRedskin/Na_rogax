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
    
    var previewIndex: IndexPath?
    var duration = ["2", "2,5", "3", "3,5", "4"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == DateCollectionView{
            return 7
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        previewIndex = indexPath

        
        
        if collectionView == DateCollectionView{
            
            collectionView.cellForItem(at: indexPath)?.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 2
            collectionView.cellForItem(at: indexPath)?.layer.cornerRadius = 4
            
            //collectionView.reloadData()
        } else {
            //collectionView.cellForItem(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
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
