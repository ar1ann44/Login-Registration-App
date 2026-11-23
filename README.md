# Login & Registration App

Final project for 106 Ch 13 - UI Testing with XCTest.

SwiftUI app made with MVVM that has a Login screen, a Registration screen and a Home/Welcome screen.

## Features
- Login with email and password (error messages if something is wrong)
- Register a new account (username, email, password, confirm password)
- Validation: email format, empty fields, minimum 6 characters, at least 1 number, passwords must match
- Users are saved in memory
- Home screen shows "Welcome, username!"

## Sample account
- Email: `student@test.com`
- Password: `student123`

## Tests
- 10 Unit Tests (`LoginRegisterCh13Tests`)
- 5 UI Tests (`LoginRegisterCh13UITests`)

Run them in Xcode with `Cmd + U`.
