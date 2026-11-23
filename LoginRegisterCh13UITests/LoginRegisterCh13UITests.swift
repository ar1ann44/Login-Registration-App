//
//  LoginRegisterCh13UITests.swift
//  LoginRegisterCh13UITests
//
//  Created by Ariana Osuna  on 17/11/26.
//

import XCTest

final class LoginRegisterCh13UITests: XCTestCase {

    // create app
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    
    func test01_elementsExist() throws {
        
        XCTAssertTrue(app.textFields["emailField"].exists, "Email field should be visible")
        XCTAssertTrue(app.secureTextFields["passwordField"].exists, "Password field should be visible")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Login button should be visible")
    }
    
    
    //MARK: - Login flow
    
    func test02_loginFlowGoesToHome() throws {
        
        // type the email
        let emailField = app.textFields["emailField"]
        emailField.tap()
        emailField.typeText("student@test.com")
        
        // type the password
        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("student123")
        
        // press login
        app.buttons["loginButton"].tap()
        
        // we should be in the home screen
        let welcome = app.staticTexts["welcomeLabel"]
        
        XCTAssertTrue(welcome.waitForExistence(timeout: 3), "Home screen did not appear")
        XCTAssertEqual(welcome.label, "Welcome, Student!")
    }
    
    
    //MARK: - Registration flow
    
    func test03_registrationFlowCreatesAccount() throws {
        
        // go to register screen
        app.buttons["goToRegisterButton"].tap()
        
        let usernameField = app.textFields["registerUsernameField"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 3), "Register screen did not appear")
        
        usernameField.tap()
        usernameField.typeText("ariana")
        
        app.textFields["registerEmailField"].tap()
        app.textFields["registerEmailField"].typeText("ariana@test.com")
        
        app.secureTextFields["registerPasswordField"].tap()
        app.secureTextFields["registerPasswordField"].typeText("hello123")
        
        app.secureTextFields["confirmPasswordField"].tap()
        app.secureTextFields["confirmPasswordField"].typeText("hello123")
        
        app.buttons["registerButton"].tap()
        
        let message = app.staticTexts["registerMessageLabel"]
        
        XCTAssertTrue(message.exists, "There is no label with that ID")
        XCTAssertTrue(message.label.contains("Account created"))
    }
    
    
    //MARK: - Error handling
    
    func test04_errorMessageAppearsWhenWrongCredentials() throws {
        
        app.textFields["emailField"].tap()
        app.textFields["emailField"].typeText("wrong@test.com")
        
        app.secureTextFields["passwordField"].tap()
        app.secureTextFields["passwordField"].typeText("321")
        
        app.buttons["loginButton"].tap()
        
        let message = app.staticTexts["loginMessageLabel"]
        
        XCTAssertTrue(message.exists, "There is no label with that ID")
        XCTAssertTrue(message.label.contains("Error"))
    }
    
    func test05_errorMessageAppearsWhenEmptyLogin() throws {
        
        // press login without typing anything
        app.buttons["loginButton"].tap()
        
        let message = app.staticTexts["loginMessageLabel"]
        
        XCTAssertTrue(message.exists, "There is no label with that ID")
        XCTAssertEqual(message.label, "Error, please fill all the fields")
    }

}
