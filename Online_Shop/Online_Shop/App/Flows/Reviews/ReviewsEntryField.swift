//
//  ReviewsEntryField.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/25/22.
//

import SwiftUI

struct ReviewsEntryField: View {
    @StateObject var viewModel: ReviewsViewModel
    @StateObject var mainMenuView: MainMenuViewModel
    let id: String

    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $viewModel.textName)
            TextField("Enter your review text", text: $viewModel.text)
            HStack {
                Text("Cancel")
                    .padding(.leading, 5)
                Spacer()
                Button("Save") {
                    viewModel.saveReview(id: id)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        mainMenuView.getProductList(categoryID: mainMenuView.searchText)
                    }
                }.padding(.trailing, 5.0)
                    .foregroundColor(.blue)
            }
            Spacer()
        }.alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
