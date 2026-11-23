//
//  RegisterView.swift
//  LoginRegisterCh13
//
//  Created by Ariana Osuna  on 17/11/26.
//

import SwiftUI
import Combine

struct RegisterView: View {
    
    // we use @ObservedObject because the viewmodel was created in the ContentView
    // this way both screens share the same list of users
    @ObservedObject var viewModel:AuthViewModel
    
    
    var body: some View {
        VStack(spacing: 24){
            
            // ------ Header section -------
            
            Image(systemName: "person.badge.plus")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Create Account")
                .font(.title.bold())
            
            // ---------- Input Section -----
            
            VStack(spacing: 16){
                
                TextField("Enter username...", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .accessibilityIdentifier("registerUsernameField")
                
                TextField("Enter email...", text: $viewModel.registerEmail)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .accessibilityIdentifier("registerEmailField")
                
                SecureField("Enter password...", text: $viewModel.registerPassword)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("registerPasswordField")
                
                SecureField("Confirm password...", text: $viewModel.confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("confirmPasswordField")
                
            }.padding(.horizontal)
            
            // ------ Button Section --------
            
            Button(action: viewModel.register){
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.horizontal)
            .accessibilityIdentifier("registerButton")
            
            
            // ------ Validation message -------
            // green if the account was created, red if there is an error
            
            if !viewModel.registerMessage.isEmpty{
                Text(viewModel.registerMessage)
                    .foregroundStyle(viewModel.isRegistered ? .green : .red)
                    .accessibilityIdentifier("registerMessageLabel")
            }
            
            Spacer()
        }
        .padding(.top, 20)
        // when we leave the screen we clean the message
        .onDisappear{
            viewModel.registerMessage = ""
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
