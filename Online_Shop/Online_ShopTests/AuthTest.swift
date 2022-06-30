//
//  AuthTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/28/22.
//

import XCTest
import Alamofire

@testable import Online_Shop

class AuthTest: XCTestCase {
    var expectation = XCTestExpectation(description: "TestingAuth...")
    var auth: AuthRequestFactory!
    var isAuthSuccesfull: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        auth = factory.makeAuthRequestFactory()
        isAuthSuccesfull = false
    }

    override func tearDownWithError() throws {
        auth = nil
        isAuthSuccesfull = nil
    }
    
    func testAuth() {
        auth.login(userName: userDataStub.username,
                   password: userDataStub.password) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isAuthSuccesfull = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isAuthSuccesfull, "The auth is unsuccessful")
    }
}
