//
//  CarsViewModelTests.swift
//  Auto1CarsTests
//
//  Created by Amir Abbas Kashani on 10/11/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import XCTest
@testable import Auto1Cars

class CarsViewModelTests: XCTestCase {
    
    var viewModel:CarsViewModel!
    var cars: Cars!
    
    override func setUp()
    {
        guard let wkda = Wkda(JSON: ["107":"107"]) else { fatalError() }
        viewModel = CarsViewModel(delegate: self, manufacturer: wkda)
        cars = MockDataForTests.getJsonToCars(jsonName: .CarsJson1)
        viewModel.cars = cars
    }
    
    override func tearDown()
    {
        viewModel = nil
        cars = nil
    }
    
    func testThatCarIsLoaded()
    {
        XCTAssertNotNil(cars)
        XCTAssertNotNil(cars.wkda)
    }
    
    func testThatCreateCorrectViewModel()
    {
        XCTAssertEqual(viewModel.numberOfRows, cars.wkda?.count)
    }
    func testPagination()
    {
        XCTAssertEqual(viewModel.nextPage, 1)
        guard let newData = MockDataForTests.getJsonToCars(jsonName: .CarsJson2) else {
            fatalError("couldn't load car josn 2")
        }
        viewModel.set(newCars: newData)
        XCTAssertNil(viewModel.nextPage)
    }
}

extension CarsViewModelTests:CarsViewModelProtocol
{
    func update() { }
    
    func update(title: String) { }
}

