//
//  EditScreenCell.swift
//  AVsoftTest
//
//  Created by Andrew Kolbasov on 20.08.2020.
//  Copyright © 2020 Andrew Kolbasov. All rights reserved.
//

import Foundation

import UIKit

class EditingTableViewCell: UITableViewCell {
    
    var key:UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    var value:UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [key, value].forEach{contentView.addSubview($0)}
        setConstraints()
    }
    
    func setConstraints(){
        
        key.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        key.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        key.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        key.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        value.topAnchor.constraint(equalTo: key.topAnchor).isActive = true
        value.bottomAnchor.constraint(equalTo: key.bottomAnchor).isActive = true
        value.leadingAnchor.constraint(equalTo: key.trailingAnchor, constant: 10).isActive = true
        value.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
