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
    var manufacturer: Manufacturers!
    
    override func setUp()
    {
        viewModel = ManufacturersViewModel(delegate: self)
        manufacturer = MockDataForTests.getJsonToManufacturer(jsonName: .ManufacturerJson1)
        viewModel.manufacturers = manufacturer
    }
    
    override func tearDown()
    {
        viewModel = nil
        manufacturer = nil
    }
    
    func testThatManufacturerIsLoaded()
    {
        XCTAssertNotNil(manufacturer)
        XCTAssertNotNil(manufacturer.wkda)
    }
    
    func testThatCreateCorrectViewModel()
    {
        XCTAssertEqual(viewModel.numberOfRows, manufacturer.wkda?.count)
    }
    func testPagination()
    {
        XCTAssertEqual(viewModel.nextPage, 1)
        guard let newData = MockDataForTests.getJsonToManufacturer(jsonName: .ManufacturerJson2) else {
            fatalError("couldn't load josn 2")
        }
        viewModel.set(newManufacturer: newData)
        XCTAssertNil(viewModel.nextPage)
    }

}

extension ManufacturerViewModelTests: ManufacturerViewModelProtocol
{
    func update(title: String) { }
    
    func update() { }
}
