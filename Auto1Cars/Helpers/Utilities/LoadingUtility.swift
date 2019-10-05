//
//  LoadingUtility.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/10/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import PKHUD

public class LoadingUtility: NSObject
{
    public static func showLoading()
    {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    public static func hideLoading()
    {
        PKHUD.sharedHUD.hide(true)
    }
}
