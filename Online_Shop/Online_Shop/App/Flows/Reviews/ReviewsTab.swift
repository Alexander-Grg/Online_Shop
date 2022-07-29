//
//  ReviewsTab.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/18/22.
//

import SwiftUI

struct ReviewsTab: View {
    let product: Product
    @StateObject var viewModel: MainMenuViewModel
    @StateObject var reviewViewModel: ReviewsViewModel
    @Binding var searchText: String
    @State private var isReviewAdded = false
    @State private var alertItem: AlertItem?

    var body: some View {
        VStack {
            Text("Reviews")
                .font(.system(size: 30.0))
                .bold()
            List (){
                ForEach(product.productReviews ?? []) { review in
                    Text(review.nameOfReviewer)
                        .bold()
                    Text(review.review)
                        .italic()
                }
            }
            Button("Delete review") {
                reviewViewModel.deleteReview(id: product.id)
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
                WriteAReview(viewModel: reviewViewModel, id: product.id, isReviewAdded: $isReviewAdded)
            } label: {
                Text("Write a review")
            }
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
