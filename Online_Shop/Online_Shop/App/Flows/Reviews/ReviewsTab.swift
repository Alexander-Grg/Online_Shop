//
//  ReviewsTab.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/18/22.
//

import SwiftUI

struct ReviewsTab: View {
    @StateObject var viewModel: MainMenuViewModel
    @StateObject var reviewViewModel: ReviewsViewModel
    var review: [ProductReviews]
    @Binding var searchText: String
    @State private var isReviewAdded = false
    @State private var alertItem: AlertItem?
    let id: String
    
    var body: some View {
        VStack {
            List(review, id: \.self) { reviews in
                Text(reviews.nameOfReviewer)
                    .bold()
                Text(reviews.review)
                    .italic()
            }
            Button("Delete review") {
                reviewViewModel.deleteReview(id: id)
                self.alertItem = AlertItem(title: Text("Successful"), message: Text("The latest review has been deleted"))
                
                viewModel.getProductList(categoryID: searchText)
            }
        }
        .onAppear(perform: {
            if self.isReviewAdded {
                viewModel.getProductList(categoryID: searchText)
            }
        })
        .toolbar {
            NavigationLink {
                WriteAReview(viewModel: reviewViewModel, id: id, isReviewAdded: $isReviewAdded)
            } label: {
                Text("Write a review")
            }
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}


