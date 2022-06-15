//
//  AuthRequestFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler:
               @escaping (AFDataResponse<LoginResult>)
               -> Void)
}
