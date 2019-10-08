//
//  AppDelegate.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/5/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: ApplicationDelegate
{
    override func services() -> [ApplicationService] {
        return [LoggerAppDelegateServices(),
                AppearancesAppDelegateService()]
    }
}
