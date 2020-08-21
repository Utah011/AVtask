
//
//  ViewViewController.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 19.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class ViewViewController: UIViewController {
    
    let realm = try! Realm()
    var delegate: ViewControllerDelegate?
    
    //MARK: Scroll view
    let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .lightGray
        return scroll
    }()
    
    //MARK: Profile Image
    let profileImageView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 75
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    //MARK: First name label
    let firstNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        lbl.textColor = .black
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    //MARK: second name label
    let secondNameLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        lbl.textColor = .black
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    //MARK: Telephone Number Label
    let telephoneNumberLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        lbl.textColor = .black
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    //MARK: Email Label
    let emailLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        lbl.textColor = .black
        lbl.layer.borderWidth = 1
        return lbl
    }()
    
    //MARK: Table View
    let tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .lightGray
        table.separatorStyle = .none
        return table
    }()
    
    //MARK: View will appear
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        getUserData()
    }
    
    //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let person = try! realm.objects(Person.self)
        if person.count != 0{
            getUserData()
        }else{
            getUserEmail()
        }
        tableView.dataSource = self
        tableView.register(EditingTableViewCell.self, forCellReuseIdentifier: "ViewTV")
        self.view.backgroundColor = .lightGray
        view.addSubview(scrollView)
        setScrollConstraints()
        
        [profileImageView ,firstNameLabel, secondNameLabel, telephoneNumberLabel, emailLabel, tableView].forEach{$0.addGestureRecognizer(setGesture())}
        
        
        [profileImageView ,firstNameLabel, secondNameLabel, emailLabel, telephoneNumberLabel, tableView].forEach{scrollView.addSubview($0)}
        setConstraints()
        configureNavBar()
        
    }
    
    
    //MARK: setGesture
    func setGesture() ->UITapGestureRecognizer{
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(tapHandling))
        return recogniser
    }
    
    
    //MARK: Constraints
    func setScrollConstraints(){
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setConstraints(){
    
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        firstNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50).isActive = true
        firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        firstNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        secondNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 25).isActive = true
        secondNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        secondNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        telephoneNumberLabel.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 25).isActive = true
        telephoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        telephoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        telephoneNumberLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: telephoneNumberLabel.bottomAnchor, constant: 25).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //MARK: objc functions
    @objc func tapHandling(){
        let editingVC = UINavigationController(rootViewController:EditScreen())
        editingVC.modalPresentationStyle = .fullScreen
        present(editingVC, animated: true, completion: nil)
    }
    
    @objc func exit(){
         signOut(vc: self)
     }
     
     @objc func openMenu(){
        dismiss(animated: true, completion: nil)
        delegate?.handleMenuToggle(forMenuModel: nil)
     }
    
    
    //MARK: Getting User data
    func getUserData(){
        let person = try! realm.objects(Person.self)
        firstNameLabel.text = person.first?.firstName
        secondNameLabel.text = person.first?.secondName
        telephoneNumberLabel.text = person.first?.telephoneNumber
        emailLabel.text = person.first?.email
        guard let data = person.first?.photo as Data? else {return}
        profileImageView.image = UIImage(data: data)
    }
    
 
    
    func getUserEmail(){
        guard let uid = Auth.auth().currentUser?.uid else {
            assertionFailure("Невозможно получить данные пользователя")
            return
        }
        
        Database.database().reference().child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any]{
                guard let email = dictionary["Email"] else {return}
                let person = Person()
                person.email = email as? String
                self.emailLabel.text = person.email
                try! self.realm.write{
                    self.realm.add(person)
                }
            }
        })
    }
    
    
    //MARK: configure NavBar
    func configureNavBar(){
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuimg").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "exitimg").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(exit))
    }
    
}

extension ViewViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewTV") as! EditingTableViewCell
        cell.backgroundColor = .lightGray
        cell.key.text = attributes[indexPath.row].key
        cell.value.text = attributes[indexPath.row].value
        return cell
    }
    
    
}
