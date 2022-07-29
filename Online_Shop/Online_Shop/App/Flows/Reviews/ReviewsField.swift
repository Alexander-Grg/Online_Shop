//
//  ReviewsField.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/25/22.
//

import SwiftUI

struct WriteAReview: View {
    @StateObject var viewModel: ReviewsViewModel
    let id: String
    @Binding var isReviewAdded: Bool
    @State private var alertItem: AlertItem?
    @State private var text = ""
    @State private var textName = ""
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $textName)
            TextField("Enter your review text", text: $text)
            HStack {
                Text("Cancel")
                    .padding(.leading, 5)
                Spacer()
                Button("Save") {
                    if !text.isEmpty && !textName.isEmpty {
                        viewModel.addReview(review: text,
                                            nameOfReviewer: textName,
                                            id: id)
                    } else {
                        self.alertItem = AlertItem(title: Text("Error"), message: Text("Enter your name and review"))
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        if viewModel.isAdded {
                            self.alertItem = AlertItem(title: Text("Success"), message: Text("Your review has been added"))
                            self.isReviewAdded = true
                        } else {
                            self.alertItem = AlertItem(title: Text("Error"), message: Text("Unknown error, try again later"))
                        }
                    }
                }.padding(.trailing, 5.0)
                    .foregroundColor(.blue)
            }
            Spacer()
        }.alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
