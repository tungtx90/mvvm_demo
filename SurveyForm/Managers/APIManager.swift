//
//  APIManager.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct APIManager {
    private init() {}
    
    static let headers: [String: String] = [:]
    
    static let defaultParams: [String: Any] = [
        "apiKey": Constant.StringURL.apiKey
    ]
}

// MARK: - Endpoint
extension APIManager {
    static func endpoint(path: String, _ arguments: CVarArg...) -> String {
        var components = URLComponents(string: Constant.StringURL.root)
        components?.path = String(format: path, arguments: arguments)
        return components?.url?.absoluteString ?? ""
    }
}

// MARK: - Request
extension APIManager {
    static func request(method: Network.HTTPMethod, url: String,
                        params: Network.Params, encoding: ParameterEncoding? = nil,
                        completion: @escaping (Network.Response) -> Void) {
        let parameters = defaultParams.merging(params) { $1 }
        Network.request(method: method, url: url,
                        params: parameters, parameterEncoding: encoding,
                        headers: headers) { response in
            completion(verify(response: response))
        }
    }
}

// MARK: - Response
extension APIManager {
    enum Response<Type> {
        case success(value: Type)
        case failure(error: NSError)
    }
    
    private enum Status: String {
        case ok
        case error
    }
    
    private static func verify(response: Network.Response) -> Network.Response {
        switch response.result {
        case .failure(_):
            return response
        case .success(let value):
            do {
                guard let json = try JSONSerialization.jsonObject(with: value, options: .allowFragments) as? [String: Any],
                    let status = Status(rawValue: json["status"] as? String ?? "")
                else {
                    return Network.Response(request: response.request,
                                            response: response.response,
                                            result: Network.Response.Result.failure(error: NSError.error(message: "Invalid response!")))
                }
                
                if status == .error {
                    let message = json["message"] as? String ?? ""
                    return Network.Response(request: response.request,
                                            response: response.response,
                                            result: Network.Response.Result.failure(error: NSError.error(message: message)))
                }
                return response
            } catch {
                return Network.Response(request: response.request,
                                        response: response.response,
                                        result: Network.Response.Result.failure(error: NSError.error(message: error.localizedDescription)))
            }
        }
    }
}
