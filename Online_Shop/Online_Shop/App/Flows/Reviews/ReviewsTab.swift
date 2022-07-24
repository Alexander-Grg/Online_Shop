//
//  ReviewsTab.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/18/22.
//

import SwiftUI

struct ReviewsTab: View {
    @ObservedObject var viewModel: MainMenuViewModel
    let index: Int
    
    var body: some View {
        VStack {
            Text("Product id: \(viewModel.productList[index].id)")
            List(viewModel.productList[index].productReviews ?? []) { reviews in
                Text(reviews.nameOfReviewer)
                    .bold()
                Text(reviews.review)
                    .italic()
            }
        }.toolbar {
            NavigationLink {
                WriteAReview(viewModel: ReviewsViewModel(), index: index, id: viewModel.productList[index].id)
            } label: {
                Text("Write a review")
            }
        }
    }
}

struct WriteAReview: View {
    @ObservedObject var viewModel: ReviewsViewModel
    let index: Int
    let id: Int
   
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
                    if !text.isEmpty {
                        viewModel.addReview(review: text,
                                            nameOfReviewer: textName,
                                            id: String(id))
                    } else {
                        self.alertItem = AlertItem(title: Text("Error"), message: Text("Enter your review"))
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(5))) {
                        if viewModel.isAdded {
                            self.alertItem = AlertItem(title: Text("Success"), message: Text("Your review has been added"))
                        } else {
                            self.alertItem = AlertItem(title: Text("Error"), message: Text("Unknown error, try again later"))
                        }
                    }
                }.padding(.trailing, 5.0)
                .foregroundColor(.blue)
                Spacer()
            }
        }.alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
