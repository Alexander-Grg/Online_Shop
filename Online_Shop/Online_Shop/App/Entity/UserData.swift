//
//  UserData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation

struct UserData {
    let id: Int
    let username: String
    let password: String
    let email: String
    let gender: Gender
    let creditCard: String
    let bio: String

}

enum Gender: String {
    case male = "m"
    case female = "f"
    case choose = ""
}
