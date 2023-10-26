//
//  LoginView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
                VStack {
                    Text("Online Shop")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.yellow)
                    TextField("Login", text: $viewModel.login)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    NavigationLink(isActive: $viewModel.isLogin) {
                        MainMenuView()
                    } label: {
                        Button("Sing In") {
                            viewModel.loginCheck()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign Up")
                    }
                    if viewModel.isLoading == true {
                        ProgressView("Logging in...")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }.background(
                    Image("wallpaper")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                )
                    
                
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }.accessibilityIdentifier("LoginScreen")
    }
}
