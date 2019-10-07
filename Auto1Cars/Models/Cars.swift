//
//  Cars.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/6/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import ObjectMapper

struct Cars : Mappable
{
    var page : Int?
    var pageSize : Int?
    var totalPageCount : Int?
    var wkda : [Wkda]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        page <- map["page"]
        pageSize <- map["pageSize"]
        totalPageCount <- map["totalPageCount"]
        wkda <- map["wkda"]
    }
    
}
