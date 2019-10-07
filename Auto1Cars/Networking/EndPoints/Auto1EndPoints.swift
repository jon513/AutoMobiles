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
    case manufacturer(page: Int, pageSize: Int)
    case mainTypes(page: Int, pageSize: Int)
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
        case .manufacturer:
            return "car-types/manufacturer"
        case .mainTypes:
            return "car-types/main-types"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


