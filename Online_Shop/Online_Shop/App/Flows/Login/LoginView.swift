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
                Button("Sing In") {
                    self.viewModel.getData(login: login, password: password)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink {
                    SignUpView(viewModel: SingUpViewModel())
                } label: {
//                    Button("Sign Up") {
//                    }
                    Text("Sign Up")
            
                }

            }
        }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
