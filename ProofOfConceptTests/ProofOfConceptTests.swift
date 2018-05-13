//
//  ProofOfConceptTests.swift
//  ProofOfConceptTests
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import XCTest
@testable import ProofOfConcept

class ProofOfConceptTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testCallingUrlSucceed() {
        let url = URL(string: POCConstants.POCUrl)
        let makeExpectation = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var httpResponseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            httpResponseError = error
            makeExpectation.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 60, handler: nil)
        
        XCTAssertNil(httpResponseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
}
