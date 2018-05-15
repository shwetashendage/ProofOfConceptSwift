//
//  ProofOfConceptParseTests.swift
//  ProofOfConceptParseTests
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import XCTest

class ProofOfConceptParseTests: XCTestCase {
    
    var systemUnderTest : POCServiceClass!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = POCServiceClass()
        systemUnderTest.defaultSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testCheckIfDataParsedCorrectly(){
        
        let makeExpectation = expectation(description: "Status code: 200")
        
        let url = URL(string: POCConstants.POCUrl)
        let dataTask = systemUnderTest?.defaultSession.dataTask(with: url!) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.systemUnderTest?.createFactsArray(data!)
                    makeExpectation.fulfill()
                    
                }
            }
        }
        dataTask?.resume()
        waitForExpectations(timeout: 60, handler: nil)
        
        XCTAssertGreaterThan(systemUnderTest!.factsArray.count, 0, "No Elements")
    }
    // Performance
    func test_ImageDownload_Performance() {
        
        measure {
            self.systemUnderTest?.getImageFromUrlString(urlString: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg", completion: {image, error in
                
            })
        }
    }
    
}
