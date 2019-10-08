//
//  ManufacturerTableViewCell.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class ManufacturerTableViewCell: UITableViewCell, NibLoadableProtocol
{
    @IBOutlet weak var nameLabel: UILabel!
    
    func set(manufacturer: Wkda)
    {
        nameLabel.text = "\(manufacturer.key ?? "") - \(manufacturer.value ?? "")"
    }
}
