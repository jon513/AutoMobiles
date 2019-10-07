//
//  NetworkManager.swift
//  Auto1
//
//  Created by Amir Abbas Kashani on 6/12/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import Foundation

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to login"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

struct NetworkManager
{
    static let environment : NetworkEnvironment = .production
    private let Auto1Router = Router<Auto1Api>()
    private var authenticationParams: [String : String]
    
    init(authenticationParams: [String:String])
    {
        self.authenticationParams = authenticationParams
    }
    
    func getManufacturers(forPage page: Int, completion: @escaping (_ manufacturers: Manufacturers?,_ error: String?)->())
    {
        Auto1Router.request(.manufacturer(page: page, pageSize: 10), authenticationParams: authenticationParams) { (data, urlResponse, error) in
            guard error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            if let response = urlResponse as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                    
                case .success:
                    guard let responseData = data,
                        let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                            as? Dictionary <String, AnyObject>,
                        let manufacturers = Manufacturers(JSON: json) else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                    }
                    completion(manufacturers, nil)
                    return
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
