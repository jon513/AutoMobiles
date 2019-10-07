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
        XCTAssertNil(AuthenticationBuilder.constantsForTest.key)
        let params = AuthenticationBuilder.buildApiKeyParams()
        let value = params[AuthenticationBuilder.constantsForTest.key]
        XCTAssert(params.keys.contains(AuthenticationBuilder.constantsForTest.key))
        XCTAssertNil(value)
        XCTAssertNotEqual(value, AuthenticationBuilder.constantsForTest.wa_key)
    }
}
