//
//  Auto1CarsTests.swift
//  Auto1CarsTests
//
//  Created by Amir Abbas Kashani on 10/5/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import XCTest
@testable import Auto1Cars

class AuthenticationBuilderTests: XCTestCase {
    
    func testBuildCorrctApiKey()
    {
        XCTAssertNotNil(AuthenticationBuilder.constantsForTest.wa_key)
        let params = AuthenticationBuilder.buildApiKeyParams()
        XCTAssert(params.keys.contains(AuthenticationBuilder.constantsForTest.wa_key))
        
        let value = params[AuthenticationBuilder.constantsForTest.wa_key]
        XCTAssertNotNil(value)
        XCTAssertNotEqual(value, AuthenticationBuilder.constantsForTest.wa_key)
    }
}
