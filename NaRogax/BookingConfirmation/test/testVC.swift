//
//  testVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class testVC: UIViewController {

    let dataLoader = DataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func toutch(_ sender: UIButton) {
        let myPost = PostReservePlace(email: "zlobrynya@gmail.com", name: "Nikita", phone: "89210100389", date: "2019-03-10", time_from: "12:30:00", time_to: "13:00:00", table_id: 1)
        dataLoader.postReservePlace(post: myPost) { result, error in
            print(result)
            
            //Запускаем в основном потоке
            DispatchQueue.main.async {
                switch(result.code){
                case -1:
                    break
                case 200:
                    let storyboard = UIStoryboard(name: "ReservationConfirmed", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ReservationConfirmed") as! ReservationConfirmedVC
                    vc.name = myPost.name
                    vc.phone = myPost.phone
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 451:
                    let storyboard = UIStoryboard(name: "ReservationCanceled", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ReservationCanceled") as! ReservationCanceledVC
                    vc.name = myPost.name
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                }
            }
        }
    }
}
