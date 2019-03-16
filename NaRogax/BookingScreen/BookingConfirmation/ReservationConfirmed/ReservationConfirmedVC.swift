//
//  ReservationConfirmedVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReservationConfirmedVC: UIViewController{

    private let firstTextDiscr = ", заявка на бронирование принята рестораном.\nПо указанному номеру ("
    private let lastTextDiscr = ") с Вами свяжется администратор и уточнит детали. "
    private let textPhoneNaRogax = "Если в течении 1 часа Вам не перезвонят, свяжитесь с нами по номеру \n"
    
    private let phoneText = "Телефон для связи. \n +7 (8142) 63-23-89"
    
    @IBOutlet var textView: [UILabel]!
    @IBOutlet weak var button: UIButton!
    
    var name: String = ""
    var phone: String = ""
    
    @IBAction func continueToMenu(_ sender: UIButton) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "TabsViewController")
        //self.navigationController?.pushViewController( vc, animated: false )
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 20
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView[1].text = textPhoneNaRogax
        textView[4].text = phoneText
        setAttTextView()
        setText()
    }
    
    func setAttTextView(){
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
    }
    

    func setText(){
        textView[0].text = name + firstTextDiscr + phone + lastTextDiscr
    }
}
