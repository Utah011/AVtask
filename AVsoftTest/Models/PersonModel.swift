//
//  PersonModel.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 19.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Firebase


@objcMembers class Person: Object{
    
    dynamic var firstName:String? = nil
    dynamic var secondName:String? = nil
    dynamic var telephoneNumber:String? = nil
    dynamic var email:String? = nil
    dynamic var photo: NSData? = nil
    dynamic var otherAttributes = List<otherAttributes>()
}


@objcMembers class otherAttributes:Object {
    dynamic var key:String? = nil
    dynamic var value:String? = nil
}
