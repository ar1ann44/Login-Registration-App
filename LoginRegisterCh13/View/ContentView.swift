//
//  ContentView.swift
//  LoginRegisterCh13
//
//  Created by Ariana Osuna  on 17/11/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    // we create the instance of the viewmodel here
    // @StateObject redraws the UI everytime a @Published variable changes
    @StateObject var viewModel:AuthViewModel = AuthViewModel()
    
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 24){
                
                // ------ Header section -------
                
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.blue)
                
                Text("Login")
                    .font(.title.bold())
                
                // ------------------------------
                
                // ---------- Input Section -----
                
                VStack(spacing: 16){
                    
                    TextField("Enter your email...", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    //tag to a component
                        .accessibilityIdentifier("emailField")
                    
                    SecureField("Enter your password...", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("passwordField")
                    
                }.padding(.horizontal)
                
                // ------ Button Section --------
                
                Button(action: viewModel.login){
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.horizontal)
                .accessibilityIdentifier("loginButton")
                
                
                // ------ Error message -------
                
                if !viewModel.loginMessage.isEmpty{
                    Text(viewModel.loginMessage)
                        .foregroundStyle(.red)
                        .accessibilityIdentifier("loginMessageLabel")
                }
                
                
                // ------ Go to register -------
                
                NavigationLink("Dont have an account? register"){
                    RegisterView(viewModel: viewModel)
                }
                .accessibilityIdentifier("goToRegisterButton")
                
                Spacer()
            }
            .padding(.top, 40)
            // when islogged is true we navigate to the home screen
            .navigationDestination(isPresented: $viewModel.isLoggedIn){
                HomeView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
