//
//  ReservationCanceledVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReservationCanceledVC: UIViewController {

    private let text = ", к сожалению, выбранный вами стол уже забронирован. \n Измените время, дату визита или столик и попробуйте снова."
    
    var name: String = ""
    
    @IBOutlet var textViews: [UILabel]!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textViews[0].text = name +  text
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}
