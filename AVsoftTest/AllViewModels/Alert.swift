//
//  Alert.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 19.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import RealmSwift

class AlertService {

    private init() {}

    static func addAlert(in vc: UIViewController, message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

    static func addAlertWithActions(in vc:UIViewController, title:String?,  message:String?, actions:[UIAlertAction]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach{alert.addAction($0)}
        vc.present(alert, animated: true, completion: nil)
    }

    static func addAlertForDopAttributes(in vc: UIViewController,
                         completion: @escaping (String, String) -> Void) {

        let alert = UIAlertController(title: "Добавление нового поля", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Название"
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Значение"
        }


        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { (_) in
            guard let key = alert.textFields?.first?.text, key != "" else {return}
            guard let val = alert.textFields?[1].text, val != "" else {return}
            completion(key, val)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        vc.present(alert, animated: true)
    }


    static func updateAlert(in vc: UIViewController,
                            pickUpLine: Any,
                            completion: @escaping (String, Int?, String?) -> Void) {

        let alert = UIAlertController(title: "Update Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Pick Up Line"
            lineTF.text = ""
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Enter Score"
            scoreTF.text = ""
        }
        alert.addTextField { (emailTF) in
            emailTF.placeholder = "Enter Email"
            emailTF.text = ""
        }

        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                let scoreString = alert.textFields?[1].text,
                let emailString = alert.textFields?.last?.text
                else { return }

            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString

            completion(line, score, email)
        }

        alert.addAction(action)
        vc.present(alert, animated: true)
    }

}
