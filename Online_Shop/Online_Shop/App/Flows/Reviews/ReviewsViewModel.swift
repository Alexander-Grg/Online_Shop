//
//  ReviewsViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/24/22.
//

import Foundation

final class ReviewsViewModel: ObservableObject {
    let containerBuilder = ContainerBuilder()
    var isAdded = false
    func addReview(review: String,
                   nameOfReviewer: String,
                   id: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let add = factory.makeAddReviewDataFactory()
        
        add.addReview(review: review,
                      nameOfReviewer: nameOfReviewer,
                      id: id) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isAdded = data.result == 1 ? true : false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
