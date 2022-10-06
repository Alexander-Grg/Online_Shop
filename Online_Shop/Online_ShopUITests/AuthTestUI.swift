//
//  AuthTestUI.swift
//  Online_ShopUITests
//
//  Created by Alexander Grigoryev on 8/5/22.
//

import XCTest
@testable import Online_Shop

class AuthTestUI: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLogin() {
        app.launch()
        let loginTextField = app.textFields["Login"]
        let passwordSecureField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Sing In"]
        
        loginTextField.tap()
        loginTextField.typeText("Admin")
        
        passwordSecureField.tap()
        passwordSecureField.typeText("Password")
        
        loginButton.tap()
        print(app.debugDescription)
        let nextElement = app.textFields["NextField"].firstMatch
        XCTAssert(nextElement.waitForExistence(timeout: 5.0))
    }
}
