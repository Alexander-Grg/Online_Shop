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
    
    var body: some View {

            VStack {
                Text("Online Shop")
                    .font(.largeTitle.bold())
                Text("Please enter single product ID, or category ID, to get a product list")
                TextField("Enter a search request", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchText) { _ in
                        viewModel.getProductList(categoryID: Int(searchText) ?? 0)
                    }
                
                List(viewModel.productList.indices, id: \.self) { index in
                    NavigationLink {
                        ReviewsTab(viewModel: viewModel, index: index)
                    } label: {
                            HStack {
                                Text(viewModel.productList[index].productName)
                                Text("\(viewModel.productList[index].productPrice) $")
                        }
                    }
                }
            }
        
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(viewModel: MainMenuViewModel())
    }
}
