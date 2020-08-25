//
//  Registration.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 19.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class registrationViewController: UIViewController{
    
    // Email
    let emailTextField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .orange
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email"
        txt.autocorrectionType = .no
        txt.addTarget(self, action: #selector(emailValidation), for: .editingChanged)
        return txt
    }()
    
    // EmailError
    let emailError: UILabel = {
        let lbl = UILabel()
        lbl.text = "Некорректный Email"
        lbl.textColor = .white
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // Password
    let passwordTextField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .orange
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.keyboardType = .emailAddress
        txt.placeholder = "Пароль"
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.isSecureTextEntry = true
        txt.addTarget(self, action: #selector(passwordValidation), for: .editingChanged)
        return txt
    }()
    
    // PasswordError
    let passwordError: UILabel = {
        let lbl = UILabel()
        lbl.text = "Пароль должен содержать больше 6 символов"
        lbl.textColor = .white
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // Confrim password
    let confirmPassword:UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .orange
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Подтвердите пароль"
        txt.isSecureTextEntry = true
        txt.addTarget(self, action: #selector(passwordConfrimationValidation), for: .editingChanged)
        txt.autocapitalizationType = .none
        return txt
    }()
    
    //Confrim password error
    let confirmPasswordError:UILabel = {
        let lbl = UILabel()
        lbl.text = "Пароли не совпадают"
        lbl.textColor = .white
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // SignUpButton
    let signUpButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .orange
        btn.setTitle("Зарегестрироваться", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        [emailTextField, emailError, passwordTextField, passwordError, confirmPassword, confirmPasswordError, signUpButton].forEach{self.view.addSubview($0)}
        
        setConstrains()
        view.dismissKey()

        
    }
    
    // Constrains
    func setConstrains(){
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        emailError.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        emailError.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        emailError.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
        emailError.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailError.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        passwordError.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        passwordError.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        passwordError.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
        passwordError.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        confirmPassword.topAnchor.constraint(equalTo: passwordError.bottomAnchor, constant: 30).isActive = true
        confirmPassword.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        confirmPassword.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
        confirmPassword.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        confirmPasswordError.topAnchor.constraint(equalTo: confirmPassword.bottomAnchor, constant: 8).isActive = true
        confirmPasswordError.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        confirmPasswordError.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor).isActive = true
        confirmPasswordError.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: confirmPasswordError.bottomAnchor, constant: 50).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    //Validation of Email
    @objc
    func emailValidation() {
        guard let text = emailTextField.text else {return}
        if !text.ValidEmail() {
            emailError.isHidden = false
            Logger.log("Email isn't exist")
            
        }else{
            emailError.isHidden = true
            Logger.log("Email is correct")
        }
    }
    
    //Validation of Password
    @objc
    func passwordValidation() {
        guard let password = passwordTextField.text else {
            return
            
        }
        if password.count < 6{
            passwordError.isHidden = false
            Logger.log("Password isn't exist")
        }else{
            passwordError.isHidden = true
            Logger.log("Password is correct")
        }
    }
    
    //Validation of the Password confirmation
    @objc
    func passwordConfrimationValidation() {
        guard let password = passwordTextField.text else {return}
        guard let passwordConfrim = confirmPassword.text else {return}
        if password != passwordConfrim{
            confirmPasswordError.isHidden = false
            Logger.log("Email isn't exist")
        }else{
            confirmPasswordError.isHidden = true
            Logger.log("Email is exist")
        }
    }
    
    //MARK: Handling signUpButton Tap
    @objc
    func signUpButtonTapped() {
        guard let email = emailTextField.text, email.ValidEmail() else {return}
            
        
        guard let password = passwordTextField.text, password != "" else {return}
        
        
        guard let confirmPassword = confirmPassword.text, confirmPassword == password else {return}
        
        
        //MARK: Registration Method
        if email.count != 0 && password.count != 0 && password == confirmPassword{
            Auth.auth().signIn(withEmail: email, password: " ") { (user, error) in
                if error != nil {
                    //check if email already exist
                    if (error?._code == 17009) {
                        let actions = [
                            UIAlertAction(title: "Войти", style: .cancel) { (_) in
                                self.navigationController?.popToRootViewController(animated: true)
                            },
                            UIAlertAction(title: "Продолжить", style: .default, handler: { (_) in
                                self.emailTextField.text = ""
                            })
                        ]
                        AlertService.addAlertWithActions(in: self,title: "Ошибка", message: "Ошибка регистрации", actions: actions)
                        Logger.log("Error: registration error")
                        return
                        
                    } else if(error?._code == 17011) {
                        // All good we can move on
                        self.emailError.isHidden = true
                        if createUser(email: email, password: password){
                            Logger.log("Registration was successful")
                            AlertService.addAlertWithActions(in: self, title: "Вы успешно зарегистрировались", message: nil, actions: [UIAlertAction(title: "ОК", style: .default, handler: { (_) in
                                //self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            })])
                        }
                    }
                }
            }
        }
    
}


}
