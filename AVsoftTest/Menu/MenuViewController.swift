//
//  MenuViewController.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 20.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation

import UIKit

class MenuViewController: UIViewController {
    
    var delegate:ViewControllerDelegate!
    
    let tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .lightGray
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")
        self.view.addSubview(tableView)
        setConstraints()
    }
    
    func setConstraints(){
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension MenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuTableViewCell else {
            assertionFailure("Cell is not available")
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.myLabel.text = MenuModel(rawValue: indexPath.row)?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuModel(rawValue: indexPath.row)
        delegate.handleMenuToggle(forMenuModel: menuOption!)
    }
}

extension MenuViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
