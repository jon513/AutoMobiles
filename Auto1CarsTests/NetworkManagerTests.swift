
//
//  NetworkManagerTests.swift
//  Auto1CarsTests
//
//  Created by Amir Kashani on 2019-10-07.
//  Copyright © 2019 Auto1. All rights reserved.
//

import XCTest
@testable import Auto1Cars

class NetworkManagerTests: XCTestCase
{
    var networkManager: NetworkManager!
    override func setUp()
    {
        let authenticationKeys = AuthenticationBuilder.buildApiKeyParams()
        networkManager = NetworkManager(authenticationParams: authenticationKeys)
    }

    override func tearDown()
    {
        networkManager = nil
    }

    func testGetManufactureres()
    {
        let getManufactureresExpectation = XCTestExpectation(description: "Wait for GetManufactureres services")
        
        networkManager.getManufacturers(forPage: 0) { (manufacturers, error) in
            XCTAssertNil(error, error ?? "")
            XCTAssertNotNil(manufacturers)
            XCTAssertNotNil(manufacturers?.wkda)
            XCTAssertEqual(manufacturers?.wkda?.count, 10, "number of fetched manufactureres is not 10")
            getManufactureresExpectation.fulfill()
        }
        
        wait(for: [getManufactureresExpectation], timeout: 10)
    }
    
    func testThatNetworkManagerGetCars()
    {
        let getCarsExpectation = XCTestExpectation(description: "Wait for Cars services")
        
        networkManager.getCars(forManufacturerId: "107", forPage: 0) { (cars, error) in
            XCTAssertNil(error, error ?? "")
            XCTAssertNotNil(cars)
            XCTAssertNotNil(cars?.wkda)
            XCTAssertNotEqual(cars?.wkda?.count, 10, "number of fetched manufactureres is not 10")
            getCarsExpectation.fulfill()
        }
        
        wait(for: [getCarsExpectation], timeout: 10)

    }

}
