//
//  CatalogData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation

struct CatalogData: Codable {
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products
    }
}
//
//
//struct Product: Codable {
//    let idProduct: Int
//    let productName: String
//    let price: Int
//
//    enum CodingKeys: String, CodingKey {
//        case idProduct = "id_product"
//        case productName = "product_name"
//        case price
//    }
//}
