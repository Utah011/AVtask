//
//  EditScreen.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 19.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Firebase

class EditScreen: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate {
    
    let realm = try! Realm()

    
    // ImagePicker
    let imagePicker:UIImagePickerController = {
        let ip = UIImagePickerController()
        return ip
    }()
    
    // ScrollView
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .lightGray
        return sv
    }()
    
    // Image
    private var profileImageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 75
        img.layer.borderWidth = 1
        img.clipsToBounds = true
        img.backgroundColor = .white
        return img
    }()
    
    // firstName
    private var firstNameLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Имя"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private var firstNameTextField:UITextField = {
        let txt = UITextField()
        txt.isUserInteractionEnabled = true
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 16
        return txt
    }()
    
    // SecondName
    private var secondNameLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Фамилия"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private var secondNameTextField:UITextField = {
        let txt = UITextField()
        txt.isUserInteractionEnabled = true
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 16
        return txt
    }()
    
    // PhoneNumber
    private var telephoneNumberLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Телефон"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private var telephoneNumberTextField:UITextField = {
        let txt = UITextField()
        txt.isUserInteractionEnabled = true
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 1
        txt.keyboardType = .numberPad
        txt.layer.cornerRadius = 16
        return txt
    }()
    
    // Email
    private var emailLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private var emailTextField:UITextField = {
        let txt = UITextField()
        txt.isUserInteractionEnabled = true
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.keyboardType = .emailAddress
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 16
//        txt.font = txt.font?.withSize(30)
        txt.adjustsFontSizeToFitWidth = true
        return txt
    }()
    
    // MoreInfo button
    let moreInfoButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plusimg.png"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(plusButton), for: .touchUpInside)
        return btn
    }()
    
    private var moreInfoLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Дополнительная информация"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.layer.cornerRadius = 16
        return lbl
    }()
    
    //MARK: TableView
    let tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .none
        return table
    }()
    
    //MARK: SaveButton
    let saveButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Сохранить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(SaveButtonTapped), for: .touchUpInside)
        btn.backgroundColor = .orange
        return btn
    }()

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserData()
        
        self.view.backgroundColor = .gray
        
        view.addSubview(scrollView)
        setScrollConstraints()
        
        [profileImageView ,firstNameLabel, firstNameTextField, secondNameLabel, secondNameTextField, telephoneNumberLabel, telephoneNumberTextField, emailLabel, emailTextField, moreInfoButton, moreInfoLabel, saveButton, tableView].forEach{self.scrollView.addSubview($0)}
        
        let textFields = [firstNameTextField, secondNameTextField, telephoneNumberTextField, emailTextField]
        

        
//        UITextField.connectAllTxtFieldFields(txtfields: textFields)
//        emailTextField.addDoneButtonOnKeyboard()
        
        self.view.dismissKey()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true
        tableView.dataSource = self
        tableView.register(EditingTableViewCell.self, forCellReuseIdentifier: "DopAttribute")
        
        setConstraints()
        configureNavUI()
    }
    
    
    //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 350)
//        self.saveButton.setGradientBackground(colorTop: Colors.firstColorForGradient, colorBottom: Colors.secondColorForGradient)
    }
    
    //MARK: Constraints
    func setScrollConstraints(){
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setConstraints(){

        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        firstNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50).isActive = true
        firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        firstNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        secondNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20).isActive = true
        secondNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        secondNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 8).isActive = true
        secondNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        secondNameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        telephoneNumberLabel.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 20).isActive = true
        telephoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        telephoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        telephoneNumberLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        telephoneNumberTextField.topAnchor.constraint(equalTo: telephoneNumberLabel.bottomAnchor, constant: 8).isActive = true
        telephoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        telephoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        telephoneNumberTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: telephoneNumberTextField.bottomAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        moreInfoLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        moreInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        moreInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        moreInfoLabel.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
//        moreInfoButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 80).isActive = true
        moreInfoButton.topAnchor.constraint(equalTo: moreInfoLabel.topAnchor).isActive = true
//        moreInfoButton.leadingAnchor.constraint(equalTo: moreInfoLabel.trailingAnchor, constant: 40).isActive = true
        moreInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        moreInfoButton.widthAnchor.constraint(equalToConstant: 52).isActive = true
        moreInfoButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
//
        tableView.topAnchor.constraint(equalTo: moreInfoLabel.bottomAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 500).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    //MARK: ImageView Tap and all for ProfilePhoto
    @objc func imageViewTapped(){
        AlertService.addAlertWithActions(in: self, title: nil, message: nil, actions: [
            UIAlertAction(title: "Сделать фото", style: .default, handler: { _ in
                self.openCamera()
            }),
            UIAlertAction(title: "Выбрать из фотопленки", style: .default, handler: { _ in
                self.openGallery()
            }),
            UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)
        ])
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            AlertService.addAlertWithActions(in: self, title: "Ошибка", message: "Какие-то проблемы с камерой", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)] )
        }
    }

    @objc
    func openGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          imagePicker.dismiss(animated: true, completion: nil)
          guard let image = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage).pngData() else {
              print("image Error")
              return
          }
          profileImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
          
          
        let person = try! realm.objects(Person.self)
          if person.count != 0{
              try! realm.write{
                  person.first?.photo = image as NSData
              }
          }else{
              let person = Person()
              person.photo = image as NSData
              try! realm.write{
                  realm.add(person)
              }
          }
      }

    //MARK: Save Button action
    @objc func SaveButtonTapped(){
        guard let firstName = firstNameTextField.text, firstName != "" else {return}
        
        guard let secondName = secondNameTextField.text, secondName != "" else {return}
        
        guard let number = telephoneNumberTextField.text, number != "" else {return}
        
        guard let email = emailTextField.text, email != "" else {return}
        
        
        let person = try! realm.objects(Person.self)
        
        if person.count != 0{
            try! realm.write{
                person.first?.firstName = firstName
                person.first?.secondName = secondName
                person.first?.telephoneNumber = number
                person.first?.email = email
            }
        }else{
            let person = Person()
            person.firstName = firstName
            person.secondName = secondName
            person.telephoneNumber = number
            person.email = email
            try! realm.write{
                realm.add(person)
            }
        }
        
//        let viewVC = ViewViewController()
//        viewVC.modalPresentationStyle = .fullScreen
//        present(viewVC, animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func showUserData(){
        let person = try! realm.objects(Person.self)
        firstNameTextField.text = person.first?.firstName
        secondNameTextField.text = person.first?.secondName
        telephoneNumberTextField.text = person.first?.telephoneNumber
        emailTextField.text = person.first?.email
        guard let data = person.first?.photo as Data? else {return}
        profileImageView.image = UIImage(data: data)
    }
    
    //MoreInfo button
     @objc func plusButton(){
         
         let newAttribute = otherAttributes()
     
         AlertService.addAlertForDopAttributes(in: self) { (key, val) in
             newAttribute.key = key
             newAttribute.value = val
             try! self.realm.write{
                 self.realm.add(newAttribute)
             }
             
             self.tableView.beginUpdates()
             self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
             self.tableView.endUpdates()
             self.tableView.reloadData()
         }
     }
    
    //MARK: Exit Button action
    @objc func exit(){
        signOut(vc: self)
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Nav configure
    func configureNavUI(){
        navigationController?.navigationBar.tintColor = .lightGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "closeimg").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "exitimg").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(exit))
    }
    

    
}

extension EditScreen : UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return attributes.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DopAttribute") as! EditingTableViewCell
    cell.backgroundColor = .green
    cell.key.text = attributes[indexPath.row].key
    cell.value.text = attributes[indexPath.row].value
    return cell
}


func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
        let obj = attributes[indexPath.row]
        try! realm.write{
            realm.delete(obj)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    tableView.reloadData()
}
    
}
