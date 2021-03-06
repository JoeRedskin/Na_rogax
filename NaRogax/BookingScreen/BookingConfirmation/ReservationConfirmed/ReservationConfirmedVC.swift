//
//  ReservationConfirmedVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReservationConfirmedVC: UIViewController{

    private let TEXT_CONFIRM = ", заявка на бронирование принята. \n В ближайшее время Вам позвонит наш администратори уточнит детали"
    private let TEXT_CANSEL = ", к сожалению, выбранный вами стол уже забронирован. \n Измените время, дату визита или столик и попробуйте снова."

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var confirmLabel: UILabel!

    var confirmation = true
    var name: String = ""
    
    @IBAction func continueToMenu(_ sender: UIButton) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "TabsViewController")
        //self.navigationController?.pushViewController( vc, animated: false )
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (confirmation){
            confirmLabel.text = name + TEXT_CONFIRM
        }else{
            confirmLabel.text = name + TEXT_CANSEL
        }
    }
    
    /*func setAttTextView(){
        for i in 0..<textView.count{
            textView[i].textAlignment = .center
            textView[i].textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
            switch i {
            case 3:
                textView[i].font = UIFont.systemFont(ofSize: 14)
                break
            case 4:
                textView[i].textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                textView[i].font = UIFont.systemFont(ofSize: 18)
                break
            default:
                textView[i].font = UIFont.systemFont(ofSize: 18)
                break
            }
        }
    }*/
    
}
