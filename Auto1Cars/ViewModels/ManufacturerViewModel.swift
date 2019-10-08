//
//  ManufacturerViewModel.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/7/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

protocol ManufacturerViewModelProtocol: ViewModelsProtocol {}

class ManufacturersViewModel: NSObject
{
    var delegate: ManufacturerViewModelProtocol
    init(delegate: ManufacturerViewModelProtocol)
    {
//        super.init()
        self.delegate = delegate
    }
    var numberOfRows: Int {
        return 0
    }
}
