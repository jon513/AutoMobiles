//
//  RestaurantEndPoints.swift
//  Auto1
//
//  Created by Amir Abbas Kashani on 6/12/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
    case staging
}

public enum Auto1Api {
    case manufacturers(page: Int, pageSize: Int, authenticationParams: Parameters)
    case cars(manufacturerId: String ,page: Int, pageSize: Int, authenticationParams: Parameters)
}

extension Auto1Api: EndPointTypeProtocol {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://api-aws-eu-qa-1.auto1-test.com/v1/"
        case .staging: return "http://api-aws-eu-qa-1.auto1-test.com/v1/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .manufacturers:
            return "car-types/manufacturer"
        case .cars:
            return "car-types/main-types"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    var task: HTTPTask {
        let pageKey = "page"
        let sizeKey = "pageSize"
        let manufacturerKey = "manufacturer"
        switch self {
        case .cars(let manufacturerId, let page, let pageSize, let authenticationParams):
            let urlParams = [manufacturerKey:manufacturerId, pageKey: page, sizeKey: pageSize] as [String : Any]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParams, authenticationParams: authenticationParams)
        case .manufacturers(let page, let pageSize, let authenticationParams):
            let urlParams = [pageKey: page, sizeKey: pageSize]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParams, authenticationParams: authenticationParams)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


