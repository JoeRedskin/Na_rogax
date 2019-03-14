//
//  ReservationCanceledVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReservationCanceledVC: UIViewController {

    private let text = ", заявка на бронирование отклонена : выбранный вами стол уже забронирован. \n Измените, пожалуйста, параметры запроса."
    
    var name: String = ""
    
    @IBOutlet var textViews: [UILabel]!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAttText()
        //name = "Екатерина"
        textViews[0].text = name +  text
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setAttText(){
        for i in 0..<textViews.count{
            textViews[i].textAlignment = .center
            textViews[i].textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
            if (i == 1){
                textViews[i].font = UIFont.systemFont(ofSize: 18)
            }else{
                textViews[i].font = UIFont.systemFont(ofSize: 22)
            }
        }
    }

}
