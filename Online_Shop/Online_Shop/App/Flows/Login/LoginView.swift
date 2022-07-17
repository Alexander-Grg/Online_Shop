//
//  LoginView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import SwiftUI

struct LoginView: View {
   @ObservedObject var viewModel: LoginViewModel
   @State private var login = ""
   @State private var password = ""
   @State private var alertItem: AlertItem?
   @State private var isLogin = false
    
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
                    MainMenuView(viewModel: MainMenuViewModel())
                } label: {
                    Button("Sing In") {
                        if !login.isEmpty && !password.isEmpty {
                            self.viewModel.getData(login: login, password: password)
                        } else {
                            self.alertItem = AlertItem(title: Text("Error"), message: Text("Please enter login and password"))
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(5))) {
                            if viewModel.loginResult {
                                self.isLogin = true
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                
                
   
              
                
                
                NavigationLink {
                    SignUpView(viewModel: SingUpViewModel())
                } label: {
                    Text("Sign Up")
            
                }

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
