//
//  Network.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/14/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct Network {
    typealias Params = [String: Any]
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
        
        var defaultEncoding: ParameterEncoding {
            switch self {
            case .post:
                return JSONEncoding.default
            case .get:
                return URLEncoding.default
            }
        }
    }
    
    private init() {}
}

// MARK: - Response
extension Network {
    struct Response {
        let request: URLRequest?
        let response: HTTPURLResponse?
        let result: Result
        
        enum Result {
            case success(value: Data)
            case failure(error: NSError)
        }
    }
}

// MARK: - Request
extension Network {
    static func request(method: HTTPMethod, url: String,
                        params: Params, parameterEncoding: ParameterEncoding? = nil,
                        headers: [String: String] = [:], completion: @escaping (Response) -> Void) {
        guard let request = setupRequest(method: method, url: url,
                                         params: params, parameterEncoding: parameterEncoding, headers: headers)
        else {
            let result = Response.Result.failure(error: NSError.error(message: "Cannot create request!"))
            completion(Response(request: nil, response: nil, result: result))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                let result: Response.Result = Response.Result.failure(error: error as NSError)
                completion(Response(request: request, response: response as? HTTPURLResponse, result: result))
                return
            }
            
            guard let data = data else {
                let result: Response.Result = Response.Result.failure(error: NSError.error(message: "Invalid response"))
                completion(Response(request: request, response: response as? HTTPURLResponse, result: result))
                return
            }
            
            let result: Response.Result = Response.Result.success(value: data)
            completion(Response(request: request, response: response as? HTTPURLResponse, result: result))
        }.resume()
    }
    
    private static func setupRequest(method: HTTPMethod, url: String,
                                      params: Params, parameterEncoding: ParameterEncoding?,
                                      headers: [String: String]) -> URLRequest? {
        guard let requestURL = URL(string: url) else {
            return nil
        }
        
        let encoding = parameterEncoding ?? method.defaultEncoding
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch method {
        case .get:
            var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
            components?.queryItems = (encoding as? URLEncoding)?.encode(params: params)
            request.url = components?.url
        case .post:
            request.httpBody = (encoding as? JSONEncoding)?.encode(params: params)
        }
        
        return request
    }
}

// MARK: - Parameter Encoding
protocol ParameterEncoding {}

protocol URLParameterEncoding: ParameterEncoding {
    func encode(params: Network.Params) -> [URLQueryItem]
}
extension Network {
    enum URLEncoding: URLParameterEncoding {
        case `default`
        
        func encode(params: Network.Params) -> [URLQueryItem] {
            switch self {
            case .default:
                return params.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            }
        }
    }
}

protocol JSONParameterEncoding: ParameterEncoding {
    func encode(params: Network.Params) -> Data
}
extension Network {
    enum JSONEncoding: JSONParameterEncoding {
        case `default`
        
        func encode(params: Network.Params) -> Data {
            switch self {
            case .default:
                return (try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)) ?? Data()
            }
        }
    }
}

// MARK: - Error
extension NSError {
    static func error(message: String) -> NSError {
        return NSError(domain: "networking", code: 99, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
