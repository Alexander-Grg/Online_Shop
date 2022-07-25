//
//  MainMenuView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject var viewModel: MainMenuViewModel = MainMenuViewModel()
    @StateObject var reviewsViewModel: ReviewsViewModel = ReviewsViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Online Shop")
                .font(.largeTitle.bold())
            Text("Please enter single product ID(Example: m1, d1, etc.), or category ID(d - drink, m - meals), to get a product list")
                .padding(.top, 10)
            TextField("Enter a search request", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .textCase(.lowercase)
                .onChange(of: searchText) { _ in
                    viewModel.getProductList(categoryID: searchText)
                }
            
            List(viewModel.productList, id: \.self) { product in
                NavigationLink {
                    ReviewsTab(viewModel: viewModel, reviewViewModel: reviewsViewModel, review: product.productReviews ?? [], searchText: $searchText, id: product.id)
                } label: {
                    HStack {
                        Text(product.productName)
                        Text("\(product.productPrice) $")
                    }
                }
            }
        }.onAppear {
            viewModel.getProductList(categoryID: searchText)
        }
    }
}

