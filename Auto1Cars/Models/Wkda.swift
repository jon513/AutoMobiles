//
//  Wkda.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-07.
//  Copyright © 2019 Auto1. All rights reserved.
//

import ObjectMapper

struct Wkda: Mappable
{
    var key : String?
    var value : String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map)
    {
        key     <- map["key"]
        value   <- map["value"]
    }
}
