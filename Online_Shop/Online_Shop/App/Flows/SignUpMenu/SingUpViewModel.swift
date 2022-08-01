//
//  SingUpViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import Foundation
import SwiftUI

final class SingUpViewModel: ObservableObject {
    let containerBuilder = ContainerBuilder()
    @Published var isRegistered = false
    @Published var isDataChanged = false
    
    func register(userData: UserData) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let register = factory.makeRegisterRequestFactory()
        
        register.register(userData: userData) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isRegistered = data.result == 1 ? true : false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeData(userData: UserData) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let changeData = factory.makeChangeDataRequestFactory()
        
        changeData.change(userData: userData) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isDataChanged = data.result == 1 ? true : false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createUser(id: String, username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String ) -> UserData {
        
        let userData = UserData(id: Int(id) ?? 0, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        return userData
    }
}
