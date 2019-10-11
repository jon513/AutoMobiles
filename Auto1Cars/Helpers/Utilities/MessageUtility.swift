//
//  MessageUtility.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/10/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class MessageUtility: NSObject
{
    
    /// Create a simple message alert
    /// - Parameter title: alert controller title
    /// - Parameter message: alert controller message
    public static func createASimpleAlert(title: String = "", message: String = "") -> UIAlertController
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
}
