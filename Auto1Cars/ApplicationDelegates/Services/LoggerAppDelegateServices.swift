//
//  LoggerAppDelegateServices.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/5/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class LoggerAppDelegateServices: ApplicationService
{
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        Logger.initializeLogger()
        return true
    }
}
