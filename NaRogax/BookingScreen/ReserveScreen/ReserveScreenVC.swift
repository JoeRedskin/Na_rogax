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
        
        TableInfoLabel.text = table_info.replacingOccurrences(of: "Стол: ", with: "")
        DateLabel.text = table_date
        TimeLabel.text = table_time
        
        let name = UserDefaultsData.shared().getName()
        let phone = UserDefaultsData.shared().getPhone()
        PersonNameLabel.text = name
        PersonPhoneLabel.text = phone
        
        if name.isEmpty || phone.isEmpty{
            if (!DataLoader.shared().testNetwork()){
                self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
                ReserveBtn.isEnabled = true
            } else {
                DataLoader.shared().viewUserCredentials(){ result, error in
                    if (error?.code == 200){
                        UserDefaultsData.shared().saveName(name: result.data.name)
                        UserDefaultsData.shared().savePhone(phone: result.data.phone)
                        self.PersonNameLabel.text = result.data.name
                        self.PersonPhoneLabel.text = result.data.phone
                    }else{
                        self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func onReserveBtnTap(_ sender: UIButton) {
        ReserveBtn.isEnabled = false
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
            ReserveBtn.isEnabled = true
        } else {
            var data = RequestPostReservePlace()
            data.date = self.date
            data.table_id = table_id
            data.time_from = time_from
            data.date_to = date_to
            data.time_to = time_to
            data.email = UserDefaultsData.shared().getEmail()
            
            DataLoader.shared().reserveTable(data: data){ result in
                if result != nil {
                    let storyboard = UIStoryboard(name: "ReservationConfirmed", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ReservationConfirmed") as! ReservationConfirmedVC
                    vc.name = self.PersonNameLabel.text!
                    if (result?.code == 200){
                        vc.confirmation = true
                    } else {
                        vc.confirmation = false
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
            }}
        }
    }
}
