//
//  LoginViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import Foundation

@MainActor final class LoginViewModel: ObservableObject {
    @Published var loginResult = false
    let containerBuilder = ContainerBuilder()
    
    func getData(login: String, password: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let auth = factory.makeAuthRequestFactory()
        
        auth.login(userName: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result.result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.loginResult = login.result == 1 ? true : false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
