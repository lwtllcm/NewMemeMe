//
//  TestTextFieldDelegate.swift
//  MemeMe1.0
//
//  Created by Laurie Wheeler on 1/13/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit

class  TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    override init() {
        super.init()
    }
    
    func textFieldDidBeginEditing( _ textField: UITextField) {
        print("textFieldDidBeginEditing")
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersInRange")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
}
