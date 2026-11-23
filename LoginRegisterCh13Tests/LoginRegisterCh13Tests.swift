//
//  LoginRegisterCh13Tests.swift
//  LoginRegisterCh13Tests
//
//  Created by Ariana Osuna  on 17/11/26.
//

import XCTest

@testable import LoginRegisterCh13

final class LoginRegisterCh13Tests: XCTestCase {
    
    var sut:AuthViewModel!
    
    // 2. create the setup
    override func setUp() {
        
        super.setUp()
        sut = AuthViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    //MARK: - email val
    
    func test01_InvalidEmailFormatReturnsFalse(){
        //Arrange
        let badEmail:String = "studenttest.com"
        
        let result = sut.isValidEmail(badEmail)
        
        //Assert
        XCTAssertFalse(result, "Email without @ should not be valid")
    }
    
    func test02_EmptyEmailReturnsFalse(){
        //Arrange
        let emptyEmail:String = ""
        
        let result = sut.isValidEmail(emptyEmail)
        
        //Assert
        XCTAssertFalse(result, "Empty email should not be valid")
    }
    
    func test03_CorrectEmailReturnsTrue(){
        //Arrange
        let goodEmail:String = "student@test.com"
        
        let result = sut.isValidEmail(goodEmail)
        
        //Assert
        XCTAssertTrue(result)
    }
    
    
    //MARK: - Password Validation
    
    func test04_WeakPasswordReturnsFalse(){
        //Arrange
        let weakPassword:String = "abc1"   // less than 6 characters
        
        let result = sut.isValidPassword(weakPassword)
        
        //Assert
        XCTAssertFalse(result, "Password with less than 6 characters should not be valid")
    }
    
    func test05_PasswordWithoutNumberReturnsFalse(){
        //Arrange
        let noNumberPassword:String = "abcdefgh"
        
        let result = sut.isValidPassword(noNumberPassword)
        
        //Assert
        XCTAssertFalse(result, "Password without a number should not be valid")
    }
    
    
    //MARK: - Empty Fields
    
    func test06_EmptyLoginShowsError(){
        //Arrange
        sut.email = ""
        sut.password = ""
        
        sut.login()
        
        //Assert
        XCTAssertFalse(sut.isLoggedIn)
        XCTAssertTrue(sut.loginMessage.contains("Error"))
    }
    
    
    //MARK: - Password Match
    
    func test07_ConfirmPasswordMismatchShowsError(){
        //Arrange
        sut.username = "ariana"
        sut.registerEmail = "ariana@test.com"
        sut.registerPassword = "hello123"
        sut.confirmPassword = "hello321"
        
        sut.register()
        
        //Assert
        XCTAssertFalse(sut.isRegistered)
        XCTAssertEqual(sut.registerMessage, "Error, passwords do not match")
    }
    
    
    //MARK: - Login Logic
    
    func test08_SuccessfulLogin(){
        //Arrange -> hardcoded account
        sut.email = "student@test.com"
        sut.password = "student123"

        sut.login()
        
        //Assert
        XCTAssertTrue(sut.isLoggedIn)
        XCTAssertEqual(sut.currentUser?.username, "Student")
    }
    
    func test09_WrongPasswordShowsError(){
        //Arrange
        sut.email = "student@test.com"
        sut.password = "wrong123"

        sut.login()
        
        //Assert
        XCTAssertFalse(sut.isLoggedIn)
        XCTAssertEqual(sut.loginMessage, "Error, invalid email or password")
    }
    
    func test10_RegisterNewUserAndLogin(){
        //Arrange
        sut.username = "ariana"
        sut.registerEmail = "ariana@test.com"
        sut.registerPassword = "hello123"
        sut.confirmPassword = "hello123"

        sut.register()
        
        sut.email = "ariana@test.com"
        sut.password = "hello123"
        sut.login()
        
        //Assert
        XCTAssertTrue(sut.isRegistered)
        XCTAssertEqual(sut.users.count, 2)
        XCTAssertTrue(sut.isLoggedIn)
    }

}
