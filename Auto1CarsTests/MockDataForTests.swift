//
//  MockDataForTests.swift
//  Auto1CarsTests
//
//  Created by Amir Abbas Kashani on 10/9/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit
@testable import Auto1Cars

enum JsonNames: String {
    case Json1
    case Json2
}

class MockDataForTests
{
    static func getJsonToManufacturer(jsonName: JsonNames) -> Manufacturers?
    {
        let bundle = Bundle(for: self)
        guard let url = bundle.url(forResource: jsonName.rawValue, withExtension: "json") else {
            return nil
        }
        do {
            let jsonString = try String(contentsOf: url)
            let json = convertToDictionary(text: jsonString)
            var manufacturer = Manufacturers(JSONString: jsonString)
            var wkdas = [Wkda]()
            let wkdaDict = json?["wkda"] as? Dictionary<String,String> ?? Dictionary<String,String>()
            for (key,value) in wkdaDict {
                if var wkda = Wkda(JSONString: ""){
                    wkda.key = key
                    wkda.value = value
                    wkdas.append(wkda)
                }
            }
            manufacturer?.wkda = wkdas
            return manufacturer
        } catch {
            return nil
        }
    }
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
