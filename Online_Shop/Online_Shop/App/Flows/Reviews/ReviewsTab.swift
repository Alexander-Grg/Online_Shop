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
                WriteAReview(viewModel: viewModel, index: index, id: viewModel.productList[index].id)
            } label: {
                Text("Write a review")
            }
        }
        }
    }

struct WriteAReview: View {
    @ObservedObject var viewModel: MainMenuViewModel
    let index: Int
    let id: Int
 
    @State private var text = ""
    
    var body: some View {
        VStack {
//            Text("\()")
        
            TextField("Enter your review text", text: $text)
            HStack {
                Text("Cancel")
                    .padding(.leading, 5)
                    Spacer()
                Button {
                    if !text.isEmpty {
                        
                    }
                } label: {
                    Text("Save")
                }
                .padding(.trailing, 5)
            }.foregroundColor(.blue)
            Spacer()
        }
    }
}

