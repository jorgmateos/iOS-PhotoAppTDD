//
//  MockURLProtocol.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 26/9/22.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let signupError = MockURLProtocol.error {
            let error = NSError(domain: "testingError",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey: signupError.localizedDescription])
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // empty
    }
    
    
}
