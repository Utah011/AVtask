//
//  AboutViewController.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 20.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    var delegate: ViewControllerDelegate!
    
    let textView:UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = false
        tv.text = "TechStack: UIKit, Realm, Firebase"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.textAlignment = .center
        tv.backgroundColor = .lightGray
        tv.font = tv.font?.withSize(16)
        tv.sizeToFit()
        tv.isScrollEnabled = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .lightGray
        
        view.addSubview(textView)
        setconstraints()
        configureNavUI()
    }
    
    
    //MARK: Constraints
    func setconstraints(){
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: objc function
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
