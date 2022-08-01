//
//  LoginView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var login = ""
    @State private var password = ""
    @State private var alertItem: AlertItem?
    @State private var isLogin = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    Image("wallpaper")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                }
                VStack {
                    Text("Online Shop")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.yellow)
                    TextField("Login", text: $login)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    NavigationLink(isActive: $isLogin) {
                        MainMenuView()
                    } label: {
                        Button("Sing In") {
                            if !login.isEmpty && !password.isEmpty {
                                self.viewModel.getData(login: login, password: password)
                                self.isLoading = true
                            } else {
                                self.alertItem = AlertItem(title: Text("Error"), message: Text("Please enter login and password"))
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                if viewModel.loginResult {
                                    self.isLogin = true
                                    self.isLoading = false
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign Up")
                        
                    }
                    if self.isLoading == true {
                        ProgressView("Logging in...")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                }
            }.alert(item: $alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
