//
//  GetSingleProductData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

class GetSingleProductData: AbstractRequestFactory {
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetSingleProductData: GetSingleProductDataFactory {
    func getData(id: Int,
                 completionHandler:
                 @escaping (AFDataResponse<SingleProductData>)
                 -> Void) {
        let requestModel = GetSingleProduct(baseUrl: baseUrl,
                                            id: id)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension GetSingleProductData {
    struct GetSingleProduct: RequestRouter {
        
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "getGoodById.json"
        
        let id: Int
        var parameters: Parameters? {
            return [
                "id_product" : id
            ]
        }
    }
}

