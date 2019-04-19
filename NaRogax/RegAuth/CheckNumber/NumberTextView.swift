//
//  NumberTextView.swift
//  NaRogax
//
//  Created by User on 22/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class NumberTextView: UITextField {
    var cutPasteProt: CutPasteProtocol? = nil
    private var clearTextField = true
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) ||
            action == #selector(UIResponderStandardEditActions.cut(_:)){
            return false
        }
        if action == #selector(UIResponderStandardEditActions.paste(_:)){
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    func setClear(){
        text = "0"
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        clearTextField = true
    }
    
    override public func deleteBackward() {
        cutPasteProt?.deleteBackward()
        super.deleteBackward()
    }
    
    
    
    override func cut(_ sender: Any?) {
        cutPasteProt?.setText()
        super.cut(sender)
    }
    
    override func paste(_ sender: Any?) {
        cutPasteProt?.setText()
        //super.paste(sender)
    }
    
    func setBottomLine(borderColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)) {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 4.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) + 8, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}
