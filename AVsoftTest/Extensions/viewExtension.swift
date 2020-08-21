//
//  viewExtension.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 20.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation

import UIKit

extension UIView{
    func dismissKey(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        self.endEditing(true)
    }
}
