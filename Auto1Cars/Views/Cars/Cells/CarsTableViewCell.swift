//
//  CarsTableViewCell.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell, NibLoadableProtocol
{

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .boldSystemFont(ofSize: 18)
            nameLabel.textColor = .systemTeal
        }
    }
    
    func set(car: Wkda)
    {
        nameLabel.text = "\(car.key ?? "") - \(car.value ?? "")"
    }
}
