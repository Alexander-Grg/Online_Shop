//
//  Online_ShopApp.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/9/22.
//

import SwiftUI
import Firebase

@main
struct Online_ShopApp: App {
    @StateObject var viewModel = MainMenuViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
