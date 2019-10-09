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
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointTypeProtocol>: NetworkRouter
{
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
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
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest
    {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                try configureParameters(bodyEncoding: .jsonEncoding, request: &request)
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters,
                                    let authenticationParams):
                
                var finalParams = urlParameters 
                for (k,v) in authenticationParams {
                    finalParams[k] = v
                }
                
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: finalParams,
                                        request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let authenticationParams,
                                              let additionalHeaders):
                var finalParams = urlParameters 
                for (k,v) in authenticationParams {
                    finalParams[k] = v
                }
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: finalParams,
                                        request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters? = nil,
                                         bodyEncoding: ParameterEncoding = ParameterEncoding.urlAndJsonEncoding,
                                         urlParameters: Parameters? = nil,
                                         requestParameters: Parameters? = nil,
                                         request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
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

