//
//  FakeBasket.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/26/22.
//

import Foundation
import SwiftUI

final class FakeBasket: ObservableObject {
    @Published var isEmpty = true
    @Published var totalPrice = 0
    @Published var dictOfProducts: Dictionary<String, [Product]> = [:]
    
    func group(product: Product) {
        if dictOfProducts.keys.contains(product.productName) {
            dictOfProducts[product.productName]?.append(product)
        } else  {
            dictOfProducts.updateValue([product], forKey: product.productName)
        }
    }
    
    
    func countProducts(product: Product) -> Int {
        var totalcount = 0
        if dictOfProducts.keys.contains(product.productName) {
            totalcount = dictOfProducts[product.productName]!.count
        } else {
            totalcount = 0
        }
        return totalcount
    }
}
