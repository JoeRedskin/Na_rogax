//
//  ReserveScreenVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReserveScreenVC: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PersonNameLabel: UILabel!
    
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PersonPhoneLabel: UILabel!
    
    @IBOutlet weak var TableInfoLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var ReserveBtn: UIButton!
    
    var table_id = 0
    var time_from = ""
    var date_to = ""
    var time_to = ""
    var date = ""
    
    var table_info = ""
    var table_time = ""
    var table_date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReserveBtn.isEnabled = true
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        TableInfoLabel.text = table_info
        DateLabel.text = table_date
        TimeLabel.text = table_time
        
        let name = UserDefaults.standard.string(forKey: "Name") ?? ""
        let phone = UserDefaults.standard.string(forKey: "Phone") ?? ""
        
        if name + phone != "" {
            PersonNameLabel.text = name
            PersonPhoneLabel.text = phone
        }
    }
    
    @IBAction func onReserveBtnTap(_ sender: UIButton) {
        ReserveBtn.isEnabled = false
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
            ReserveBtn.isEnabled = true
        } else {
            if let name = PersonNameLabel.text, let phone = PersonPhoneLabel.text {
                    
                UserDefaults.standard.set(name, forKey: "Name")
                UserDefaults.standard.set(phone, forKey: "Phone")

                var data = RequestPostReservePlace()
                data.date = self.date
                data.name = name
                data.phone = phone
                data.table_id = table_id
                data.time_from = time_from
                data.date_to = date_to
                data.time_to = time_to
                //TO DO: Change email
                data.email = "trop1nka825@gmail.com"
            
                DataLoader.shared().reserveTable(data: data){ result in
                if result != nil {
                    if (result?.code == 200){
                        let storyboard = UIStoryboard(name: "ReservationConfirmed", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationConfirmed") as! ReservationConfirmedVC
                        vc.name = data.name
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
//                        print("**************")
//                        print(result ?? "strange")
//                        print("**************")
                        let storyboard = UIStoryboard(name:
                                "ReservationCanceled", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationCanceled") as! ReservationCanceledVC
                        vc.name = data.name
                        self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
}
