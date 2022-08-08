//
//  GetReviewsDataTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 8/5/22.
//

import XCTest
@testable import Online_Shop

class AddDeleteReviewsDataTest: XCTestCase {
    let expectation = XCTestExpectation(description: "Adding reviewsTest...")
    let expectationOfDeletion = XCTestExpectation(description: "Deleting reviews...")
    var reviews: AddReviewDataFactory!
    var isDataReceived: Bool!

    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        reviews = factory.makeAddReviewDataFactory()
        isDataReceived = false
    }

    override func tearDownWithError() throws {
       reviews = nil
       isDataReceived = nil
    }

    func testByAddingReviews() {
        reviews.addReview(review: "TestReview",
                             nameOfReviewer: "Test",
                             id: "m1") { [weak self] response in
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
    
    func testOfDeletionReviews() {
        reviews.deleteReview(id: "m1") { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isDataReceived = data.result == 1 ? true : false
            case .failure(let error):
                print(error)
                XCTFail()
            }
            self?.expectationOfDeletion.fulfill()
        }
        wait(for: [expectationOfDeletion], timeout: 10.0)
    }
}
