//
//  APIManagerTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/18/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest

@testable import SurveyForm

class APIManagerTests: XCTestCase {
    func testEndpoint() {
        let url = Constant.StringURL.root + Constant.StringURL.Headlines.getTop
        
        let endPoint = APIManager.endpoint(path: Constant.StringURL.Headlines.getTop)
        XCTAssert(endPoint == url, "endPoint should be \(url)")
    }
    
    func testEndpointWithParams() {
        let id = 100
        let path = "/new/%i"
        let url = Constant.StringURL.root + String(format: path, id)
        
        let endPoint = APIManager.endpoint(path: path, id)
        XCTAssert(endPoint == url, "endPoint should be \(url)")
    }
    
    func testRequest() {
        let expectation = XCTestExpectation(description: "testDefaultHeadersAndParams")
        let url = APIManager.endpoint(path: Constant.StringURL.Headlines.getTop)
        
        var expectedURLComponents = URLComponents(string: url)
        let queryItems: [URLQueryItem] = [
            "country": "us",
            "apiKey": Constant.apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        expectedURLComponents?.queryItems = queryItems
        
        let params: [String: Any] = [
            "country": "us"
        ]
        APIManager.request(method: .get, url: url, params: params) { (response) in
            XCTAssert(response.request?.httpMethod?.uppercased() == Network.HTTPMethod.get.rawValue.uppercased(),
                      "Request method should be \(Network.HTTPMethod.get.rawValue)")
            XCTAssert(response.request?.allHTTPHeaderFields == APIManager.headers, "Request headers should be \(APIManager.headers)")
            
            let components = URLComponents(url: response.request!.url!, resolvingAgainstBaseURL: true)
            XCTAssert(components?.path == expectedURLComponents?.path, "Request path should be \(expectedURLComponents?.path ?? "")")
            XCTAssert(components?.scheme == expectedURLComponents?.scheme, "Request scheme should be \(expectedURLComponents?.scheme ?? "")")

            for queryItem in expectedURLComponents!.queryItems! {
                if components?.queryItems?.contains(where: { $0.name == queryItem.name && $0.value == queryItem.value }) == false {
                    XCTFail("Request params should contain \(queryItem.description)")
                    break
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testSuccessfulResponse() {
        let expectation = XCTestExpectation(description: "testSuccessfulResponse")
        let url = APIManager.endpoint(path: Constant.StringURL.Headlines.getTop)
        let params: [String: Any] = [
            "country": "us"
        ]
        APIManager.request(method: .get, url: url, params: params) { (response) in
            switch response.result {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(_):
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testErrorResponse() {
        let expectation = XCTestExpectation(description: "testSuccessfulResponse")
        let url = APIManager.endpoint(path: Constant.StringURL.Headlines.getTop)
        
        APIManager.request(method: .get, url: url, params: [:]) { (response) in
            switch response.result {
            case .failure(_):
                break
            case .success(_):
                XCTFail("Request should be failed")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
}
