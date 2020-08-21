//
//  Login.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 18.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class loginViewController: UIViewController{
    
    // Email
    let emailTextField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .orange
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email"
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
        txt.autocapitalizationType = .none
        txt.isSecureTextEntry = true
        txt.addTarget(self, action: #selector(passwordValidation), for: .editingChanged)
        return txt
    }()
    
    // PasswordError
    let passwordError: UILabel = {
        let lbl = UILabel()
        lbl.text = "Пароль должен содержать больше 6 символов"
        lbl.textColor = .red
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // LoginButton
    let loginButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .orange
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        return btn
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
    
    //ProgressBar
    let progressBar: UIProgressView = {
        let line = UIProgressView()
        line.isHidden = true
        line.progress = 0
        line.translatesAutoresizingMaskIntoConstraints = false
        line.progressTintColor = .white
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        [emailTextField, emailError, passwordTextField, passwordError, loginButton, signUpButton, progressBar].forEach{self.view.addSubview($0)}
        
        setConstrains()
        view.dismissKey()

        
        
    }
    
    // Constrains
    func setConstrains(){
        emailTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
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
        passwordError.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        passwordError.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        passwordError.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordError.bottomAnchor, constant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        progressBar.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -50).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    }
    
    
    //Progress if validation of Email was successful
    @objc
    func emailValidation() {
        guard let text = emailTextField.text else {return}
        if !text.ValidEmail() {
            emailError.isHidden = false
            
        }else{
            progressBar.isHidden = false
            progressBar.setProgress(0.2, animated: true)
            emailError.isHidden = true
        }
    }
    
    //Progress if validation of Password was successful
    @objc
    func passwordValidation() {
        guard let password = passwordTextField.text else {return}
        if password.count < 6{
            passwordError.isHidden = false
        }else{
            progressBar.isHidden = false
            progressBar.setProgress(0.3, animated: true)
            passwordError.isHidden = true
        }
    }
    
    
    //MARK: Handling login button tap
    @objc
    func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {return}
        
        guard let password = passwordTextField.text, password != "" else {return}
        
        progressBar.setProgress(0.8, animated: true)
        
        [emailTextField, emailError, passwordTextField, passwordError, loginButton, signUpButton].forEach{$0.alpha = 0.5}
        
        //MARK: Log in
        if email.count > 0 && password.count > 0 {
            progressBar.setProgress(0.9, animated: true)
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let error = error {
                    print(error.localizedDescription, error._code)
                    if (error._code == 17020){
                        AlertService.addAlert(in: self, message: "Нет интернет соединения")
                        self.progressBar.setProgress(0, animated: true)
                    }else if error._code == 17009{
                        let title: String? = "Ok"
                        let alertAction = [UIAlertAction(title: title,
                                                         style: .cancel,
                                                         handler: { (_) in
                                                            [self.emailTextField, self.emailError, self.passwordTextField, self.passwordError, self.loginButton, self.signUpButton].forEach{$0.alpha = 1}
                                                         }
                            )]
                        AlertService.addAlertWithActions(in: self, title: "Неверный Email или пароль", message: nil, actions: alertAction)
                        self.progressBar.setProgress(0, animated: true)
                    }
                }else{
                    self.progressBar.setProgress(1, animated: true)
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController?.dismiss(animated: true, completion: {
                        guard let app = UIApplication.shared.delegate as? AppDelegate else {return}
                        app.reloadApp()
                    })
                }
            }
        }
    }
    @objc func signUpButtonTapped(){
        let signUpVC = registrationViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    
}
