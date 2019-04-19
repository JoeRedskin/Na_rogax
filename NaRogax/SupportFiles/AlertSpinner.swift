//
//  AlertSpinner.swift
//  NaRogax
//
//  Created by User on 11/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class AlertSpinner {
    private var vSpinner : UIView?

    /*
     * Для спинера загрузки
     */
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        vSpinner = spinnerView
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            if self.vSpinner != nil{
                self.vSpinner?.removeFromSuperview()
                self.vSpinner = nil
            }
        }
    }
}
