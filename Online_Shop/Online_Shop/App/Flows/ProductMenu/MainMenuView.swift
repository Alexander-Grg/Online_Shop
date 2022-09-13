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
    @StateObject var basket: ProductCartViewModel = ProductCartViewModel()

    var body: some View {
        VStack {
            Text("""
                 Please enter single product ID (m1, d1, etc.)
                 or category ID to get a product list (d - drink, m - meals)
                 """)
                .padding(.top, 5)
            TextField("Enter a search request", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .textCase(.lowercase)
                .onChange(of: viewModel.searchText) { _ in
                    viewModel.getProductList(categoryID: viewModel.searchText)
                }
            List() {
                ForEach(viewModel.productList, id: \.self) { product in
                    NavigationLink {
                        ReviewsTab(product: product, viewModel: viewModel, reviewViewModel: reviewsViewModel)
                    } label: {
                        ProductCell(product: product, basket: basket)
                    }
                }
            }.accessibilityIdentifier("MainMenuTable")
            Spacer()
        }
        .toolbar {
            NavigationLink {
                ProductCart(basket: basket)
            } label: {
                Image(systemName: "cart.circle")
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Online Shop")
    }
}

