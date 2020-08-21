//
//  MenuTableViewCell.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 20.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    var myLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myLabel)
        
        backgroundColor = .orange
        
        myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
