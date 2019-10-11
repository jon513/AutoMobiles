//
//  Logger.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/8/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit
import SwiftyBeaver

public class Logger: NSObject
{
    public static let log = SwiftyBeaver.self
    public static func initializeLogger()
    {
        let console = ConsoleDestination()  // log to Xcode Console
        Logger.log.addDestination(console)
    }
}

