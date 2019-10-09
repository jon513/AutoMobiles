//
//  AppearancesAppDelegateService.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class AppearancesAppDelegateService: ApplicationService
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
    {
        UINavigationBar.appearance().backgroundColor = .systemBlue
        UINavigationBar.appearance().tintColor = .darkText
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkText]
        
        return true
    }
}
