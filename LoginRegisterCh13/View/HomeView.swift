//
//  HomeView.swift
//  LoginRegisterCh13
//
//  Created by Ariana Osuna  on 17/11/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel:AuthViewModel
    
    
    var body: some View {
        VStack(spacing: 24){
            
            Spacer()
            
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 70))
                .foregroundStyle(.green)
            
            // show the username of the user that logged in
            Text("Welcome, \(viewModel.currentUser?.username ?? "Student")!")
                .font(.title.bold())
                .accessibilityIdentifier("welcomeLabel")
            
            Text(viewModel.currentUser?.email ?? "")
                .foregroundStyle(.gray)
            
            Button("Logout"){
                viewModel.logout()
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("logoutButton")
            
            Spacer()
        }
        // we hide the back button, to go back the user needs to press logout
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(viewModel: AuthViewModel())
}
