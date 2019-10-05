//
//  StringUtility.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/11/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

extension String
{
    func toData() -> Data?
    {
        return data(using: .utf8)
    }
}
