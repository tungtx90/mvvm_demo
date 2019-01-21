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
        components?.path = String(format: path, arguments)
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
                        headers: headers, completion: completion)
    }
}

// MARK: - Response
extension APIManager {
    enum Response<Type> {
        case success(value: Type)
        case failure(error: NSError)
    }
}
