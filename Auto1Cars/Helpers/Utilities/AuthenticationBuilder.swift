//
//  ApiKeyBuilder.swift
//  Auto1App
//
//  Created by Amir Abbas Kashani on 9/29/19.
//  Copyright © 2019 jawabkom. All rights reserved.
//


class AuthenticationBuilder
{
    private struct K
    {
        static let key = "coding-puzzle-client-449cc9d"
        static let wa_key = "wa_key"
    }
    
    static func buildApiKeyParams () -> [String:String]
    {
        fatalError()
    }
}
#if DEBUG
extension AuthenticationBuilder
{
    public struct constantsForTest
    {
        static let key = K.key
        static let wa_key = K.wa_key
    }

}
#endif
