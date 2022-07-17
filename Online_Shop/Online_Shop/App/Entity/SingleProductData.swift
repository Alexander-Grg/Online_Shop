//
//  SingleProductData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation

//MARK: - Request to server

//struct GetProductListRequest: Content {
//    let id_category: Int
//}
//
//struct GetSingleProductRequest: Content {
//    let id_product: Int
//}

//MARK: - Response from the server


//struct GetProductListResponse: Content {
//    let products: [Product]?
//    let error: String?
//}
//
//struct Product: Content {
//    let result: Int
//    let id_product: Int
//    let product_name: String
//    let price: Int
//    let id_category: Int
//    let productReviews: [ProductReviews]?
//}
//
//struct ProductReviews: Content {
//    let review: String
//    let nameOfReviewer: String
//}

struct Product: Codable, Identifiable {
    var id = UUID()
    let result: Int
    let productID: Int
    let productName: String
    let productPrice: Int
    let categoryID: Int
    let productReviews: [ProductReviews]?
    
    enum CodingKeys: String, CodingKey {
        case result
        case productID = "id_product"
        case productName = "product_name"
        case productPrice = "price"
        case categoryID = "id_category"
        case productReviews
    }
}

struct ProductReviews: Codable {
    let review: String
    let nameOfReviewer: String
    
    enum CodingKeys: String, CodingKey {
        case review
        case nameOfReviewer
    }
}

