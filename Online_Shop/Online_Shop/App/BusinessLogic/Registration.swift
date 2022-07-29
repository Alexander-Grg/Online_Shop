//
//  Registration.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation
import Alamofire

class Registration: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension Registration: RegistrationRequestFactory {
    
    func register(
        userData: UserData,
        completionHandler: @escaping
        (AFDataResponse<RegisterUser>) -> Void) {
            let requestModel = Register(baseUrl: baseUrl, userData: userData)
            self.request(request: requestModel, completionHandler:
                            completionHandler)
        }
}

extension Registration {
    struct Register: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "registerUser.json"
        
        let userData: UserData
        var parameters: Parameters? {
            return [
                "id_user" : userData.id,
                "username" : userData.username,
                "password" : userData.password,
                "email": userData.email,
                "gender": userData.gender.rawValue,
                "credit_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
    }
}
