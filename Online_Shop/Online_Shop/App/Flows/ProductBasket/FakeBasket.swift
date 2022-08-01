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
    @Published var isPaid = false
    @Published var userMessage = ""
    let containerBuilder = ContainerBuilder()
    
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
    
    func pay(totalPrice: Int) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let payForProducts = factory.makePayForProductsDataFactory()
        
        payForProducts.pay(totalPrice: totalPrice) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isPaid = data.result == 1 ? true : false
                    self.userMessage = data.userMessage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
