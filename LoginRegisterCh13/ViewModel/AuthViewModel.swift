//
//  AuthViewModel.swift
//  LoginRegisterCh13
//
//  Created by Ariana Osuna  on 18/11/26.
//

import Foundation
import Combine

// Protocol
// ObservableObject = used to share information with a VIEW
// Published = Marks the data as "Share-able / Published"

class AuthViewModel:ObservableObject{
    
    // ------- Login variables -------
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var loginMessage:String = ""
    @Published var isLoggedIn:Bool = false
    
    // ------- Register variables -------
    @Published var username:String = ""
    @Published var registerEmail:String = ""
    @Published var registerPassword:String = ""
    @Published var confirmPassword:String = ""
    @Published var registerMessage:String = ""
    @Published var isRegistered:Bool = false
    
    // user that is logged in, we use it in the home screen
    @Published var currentUser:User? = nil
    
    // list of users saved in memory
    // we hardcode a sample account so we can login without registering
    var users:[User] = [
        User(username: "Student", email: "student@test.com", password: "student123")
    ]
    
    
    // ------- Validation section -------
    
    //MARK: - Function IsValidEmail #1 - checks if the email is not empty and has the correct format
    func isValidEmail(_ text:String) -> Bool{
        
        // email is empty -> not valid
        if text.isEmpty == true {
            return false
        }
        
        // email can not have spaces
        if text.contains(" ") {
            return false
        }
        
        // email needs a @ and a . -> ex: student@test.com
        if text.contains("@") && text.contains(".") {
            return true
        }
        
        return false
    }
    
    //MARK: - Function IsValidPassword #2 - minimum 6 characters and at least 1 number
    func isValidPassword(_ text:String) -> Bool{
        
        if text.count < 6 {
            return false
        }
        
        if containsNumber(text) == false {
            return false
        }
        
        return true
    }
    
    //MARK: - Function ContainsNumber #3 - returns true if the text has at least 1 number
    func containsNumber(_ text:String) -> Bool{
        for character in text {
            if character.isNumber == true {
                return true
            }
        }
        return false
    }
    
    //MARK: - Function PasswordsMatch #4 - checks that password and confirm password are the same
    func passwordsMatch(_ first:String, _ second:String) -> Bool{
        return first == second
    }
    
    
    // ------- Login section -------
    
    //MARK: - Function Login #5 - if the email and password are correct -> go to home, if not -> error message
    func login(){
        
        print("Trying to login with \(email)")
        
        // empty fields
        if email.isEmpty || password.isEmpty {
            loginMessage = "Error, please fill all the fields"
            isLoggedIn = false
            return
        }
        
        // wrong email format
        if isValidEmail(email) == false {
            loginMessage = "Error, invalid email format"
            isLoggedIn = false
            return
        }
        
        // look for the user inside the list
        for user in users {
            if user.email == email && user.password == password {
                currentUser = user
                loginMessage = ""
                isLoggedIn = true
                return
            }
        }
        
        // if we get here the user was not found
        loginMessage = "Error, invalid email or password"
        isLoggedIn = false
    }
    
    //MARK: - Function Logout #6 - clears the fields and goes back to login
    func logout(){
        email = ""
        password = ""
        loginMessage = ""
        currentUser = nil
        isLoggedIn = false
    }
    
    
    // ------- Register section -------
    
    //MARK: - Function Register #7 - validates the form and saves the new user in memory
    func register(){
        
        print("Trying to register \(username)")
        
        isRegistered = false
        
        // empty fields
        if username.isEmpty || registerEmail.isEmpty || registerPassword.isEmpty || confirmPassword.isEmpty {
            registerMessage = "Error, please fill all the fields"
            return
        }
        
        // email
        if isValidEmail(registerEmail) == false {
            registerMessage = "Error, invalid email format"
            return
        }
        
        // password
        if isValidPassword(registerPassword) == false {
            registerMessage = "Error, password needs 6 characters and 1 number"
            return
        }
        
        // confirm password
        if passwordsMatch(registerPassword, confirmPassword) == false {
            registerMessage = "Error, passwords do not match"
            return
        }
        
        // email already used
        for user in users {
            if user.email == registerEmail {
                registerMessage = "Error, that email is already registered"
                return
            }
        }
        
        // everything is ok -> save the user
        let newUser = User(username: username, email: registerEmail, password: registerPassword)
        users.append(newUser)
        
        registerMessage = "Account created! Now you can login"
        isRegistered = true
        
        // clean the form
        username = ""
        registerEmail = ""
        registerPassword = ""
        confirmPassword = ""
    }
    
}
