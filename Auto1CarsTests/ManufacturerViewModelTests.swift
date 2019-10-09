//
//  ManufacturerViewModelTests.swift
//  Auto1CarsTests
//
//  Created by Amir Kashani on 2019-10-09.
//  Copyright © 2019 Auto1. All rights reserved.
//

import XCTest
@testable import Auto1Cars

class ManufacturerViewModelTests: XCTestCase
{
    var viewModel:ManufacturersViewModel!
    
    override func setUp()
    {
        viewModel = ManufacturersViewModel(delegate: self)
    }
    
    override func tearDown()
    {
        viewModel = nil
    }
    
    func testExample()
    {
    }
}

extension ManufacturerViewModelTests: ManufacturerViewModelProtocol
{
    func update(title: String)
    {
    }
    
    func update()
    {
    }
}
