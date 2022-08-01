//
//  MainMenuViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/15/22.
//

import Foundation

final class MainMenuViewModel: ObservableObject {
    @Published var productList: [Product] = []
    let containerBuilder = ContainerBuilder()
    var productIndex: Int {
        productList.firstIndex(where: {$0.id == $0.id})!
    }
    
    func getProductList(categoryID: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let productList = factory.makeCatalogDataRequestFactory()
        
        productList.getData(categoryID: categoryID) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.productList = data.products
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
