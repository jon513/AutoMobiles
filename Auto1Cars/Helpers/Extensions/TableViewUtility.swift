//
//  TableViewUtility.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/10/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

extension UITableView
{
    func removeExtraCells()
    {
        self.tableFooterView = UIView(frame: .zero)
    }
}
