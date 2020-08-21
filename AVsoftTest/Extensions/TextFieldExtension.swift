//
//  TextFieldExtension.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 18.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func ValidEmail() -> Bool {
        let emailForm = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailForm)
        return emailPred.evaluate(with: self)
    }
}
