//
//  GetCatalogData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

class GetCatalogData: AbstractRequestFactory {
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

extension GetCatalogData: GetCatalogDataFactory {
    func getData(pageNumber: Int,
                 categoryID: Int,
                 completionHandler:
                 @escaping (AFDataResponse<CatalogData>)
                 -> Void) {
        let requestModel = GetCatalog(baseUrl: baseUrl, pageNumber: pageNumber, categoryID: categoryID)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension GetCatalogData {
    struct GetCatalog: RequestRouter {
        
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "catalogData.json"
        
        let pageNumber: Int
        let categoryID: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryID
            ]
        }
    }
}
