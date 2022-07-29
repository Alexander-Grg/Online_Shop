//
//  ProductCart.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/26/22.
//

import SwiftUI

struct ProductCart: View {
    
    @StateObject var basket: FakeBasket
    
    var body: some View {
        VStack {
            Text("Your products")
                .font(.system(size: 30))
                .bold()
            
            List {
                ForEach(basket.dictOfProducts.keys.sorted(), id: \.self) { key in
                    ForEach(basket.dictOfProducts[key]!) { value in
                        HStack {
                            Text(value.productName)
                                .padding(.leading, 15)
                            Spacer()
                            Text(" Price \(value.productPrice) $")
                                .padding(.trailing, 15)
                        }
                    }
                }
            }
            Text("Total price is: \(basket.totalPrice)")
            Button("Delete all products") {
                basket.dictOfProducts.removeAll()
                basket.totalPrice = 0
            }
            .foregroundColor(.red)
        }
    }
}

