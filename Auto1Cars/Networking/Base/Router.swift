//
//  Router.swift
//  Auto1
//
//  Created by Amir Abbas Kashani on 6/12/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointTypeProtocol
    func request(_ route: EndPoint, authenticationParams: [String:String], completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointTypeProtocol>: NetworkRouter
{
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, authenticationParams: [String:String], completion: @escaping NetworkRouterCompletion)
    {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route, authenticationParams: authenticationParams)
            Logger.log.verbose(request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        }catch {
            Logger.log.error(error)
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel()
    {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint, authenticationParams: [String:String]) throws -> URLRequest
    {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                try configureParameters(bodyEncoding: .urlEncoding, request: &request,
                                        authenticationParams: authenticationParams)
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request,
                                        authenticationParams: authenticationParams)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request,
                                        authenticationParams: authenticationParams)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters? = nil,
                                         bodyEncoding: ParameterEncoding = ParameterEncoding.urlAndJsonEncoding,
                                         urlParameters: Parameters? = nil,
                                         request: inout URLRequest,
                                         authenticationParams: [String:String]) throws {
        do {
            
            var finalUrlParameters = urlParameters ?? Parameters()
            for (key, value) in authenticationParams {
                finalUrlParameters[key] = value
            }
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: finalUrlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

