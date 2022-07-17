//
//  MainMenuView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var viewModel: MainMenuViewModel
    
    @State private var searchText = ""
//    private var searchResult: [Product] {
//      return  viewModel.getProductList(categoryID: searchText)
//    }

    var body: some View {
        VStack {
            Text("Online Shop")
                .font(.largeTitle.bold())
            Text("Please enter single product ID, or category ID, to get a product list")
            List(viewModel.productList) { product in
                HStack {
                    Text(product.productName)
                    Text("Price \(product.productPrice)")
                }
            }.searchable(text: $searchText)
            
        }.onAppear {
            viewModel.getProductList(categoryID: Int(searchText) ?? 0)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(viewModel: MainMenuViewModel())
    }
}
