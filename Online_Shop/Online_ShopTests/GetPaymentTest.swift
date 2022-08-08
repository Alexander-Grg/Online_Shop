//
//  GetPaymentTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 8/5/22.
//

import XCTest
@testable import Online_Shop

class GetPaymentTest: XCTestCase {
    let expectation = XCTestExpectation(description: "Getting payment response...")
    var getPayment: PayForProductsDataFactory!
    var isDataReceived: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        getPayment = factory.makePayForProductsDataFactory()
        isDataReceived = false
    }

    override func tearDownWithError() throws {
        getPayment = nil
        isDataReceived = nil
    }

    func testPayment() {
        getPayment.pay(totalPrice: 50) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isDataReceived = data.result == 1 ? true : false
            case .failure(let error):
                print(error)
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
