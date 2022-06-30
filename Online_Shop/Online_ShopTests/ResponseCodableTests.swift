//
//  ResponseCodableTests.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/28/22.
//

import XCTest
import Alamofire
@testable import Online_Shop

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "TestingResponse...")
    var errorParser: ErrorParserStub!

    override func setUpWithError() throws {
      errorParser = ErrorParserStub()
    }

    override func tearDownWithError() throws {
        errorParser = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testShouldDownloadAndParse() {
        let errorParser = ErrorParserStub()
        
        AF
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) { (response: DataResponse<PostStub, AFError>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
        
    }

}
