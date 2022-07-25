//
//  SignUpView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SingUpViewModel = SingUpViewModel()
    @State private var alertItem: AlertItem?
    @State private var id = ""
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var gender: Gender = .choose
    @State private var creditCard = ""
    @State private var bio = ""
    
    var body: some View {
        VStack() {
            Text("Registration")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Fill in your data for the registration, or update your current information")
                .multilineTextAlignment(.leading)
                .padding(.top, 5.0)
        Form {

          
            Group {
                TextField("User ID (Your unique number)", text: $id)
                    .keyboardType(.numberPad)
                TextField("Name", text: $username)
                TextField("Password", text: $password)
                TextField("Email", text: $email)
                TextField("Credit Card", text: $creditCard)
                TextField("Bio", text: $bio)
            }
            .textFieldStyle(.automatic)
            .padding(.leading, 10.0)
            
            HStack {
                Picker(selection: $gender, label: Text("Select Gender")) {
                    Text("Choose...").tag(Gender.choose)
                    Text("Male").tag(Gender.male)
                    Text("Female").tag(Gender.female)
                }
            }
        }
            Group {
                HStack {
                    Button("Register") {
                        let data = viewModel.createUser(id: id, username: username, password: password, email: email, gender: Gender(rawValue: gender.rawValue) ?? Gender.choose, creditCard: creditCard, bio: bio)
                        
                        if !id.isEmpty && !username.isEmpty && !password.isEmpty && !email.isEmpty && !creditCard.isEmpty && !bio.isEmpty && data.gender != .choose  {
                            viewModel.register(userData: data)
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(5))) {
                                if viewModel.isRegistered {
                                    self.alertItem = AlertItem(title: Text("Success"), message: Text("You've been registered"))
                                } else {
                                    self.alertItem = AlertItem(title: Text("Error"), message: Text("Registration failed, check out your data, ID can contain only numbers"))
                                }
                            }
                        } else if !id.isEmpty && !username.isEmpty && !password.isEmpty && !email.isEmpty && !creditCard.isEmpty && !bio.isEmpty && data.gender == .choose {
                            self.alertItem = AlertItem(title: Text("Error"), message: Text("You need to choose a gender"))
                        } else {
                            self.alertItem = AlertItem(title: Text("Error"), message: Text("Each field needs to be filled"))
                        }
                    }
                    Button("Update") {
                        
                        let newData = viewModel.createUser(id: id, username: username, password: password, email: email, gender: Gender(rawValue: gender.rawValue) ?? Gender.choose, creditCard: creditCard, bio: bio)
                        
                        viewModel.changeData(userData: newData)
                        
                        if viewModel.isDataChanged {
                            self.alertItem = AlertItem(title: Text("Success"), message: Text("Your data has been updated"))
                        } else {
                            self.alertItem = AlertItem(title: Text("Error, try again"), message: Text("Data isn't updated, check out your data, ID can contain only numbers"))
                        }
                    }
                }
            }   .buttonStyle(.bordered)

        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SingUpViewModel())
    }
}

