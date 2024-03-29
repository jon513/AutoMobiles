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
        return [K.wa_key:K.key]
    }
}
#if DEBUG
extension AuthenticationBuilder
{
    public struct constantsForTest
    {
        static let wa_value = K.key
        static let wa_key = K.wa_key
    }

}
#endif
