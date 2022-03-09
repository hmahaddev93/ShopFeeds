//
//  ANFExploreCardTableViewModel.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/8/22.
//

import Foundation

class ANFExploreCardTableViewModel {
    // MARK: - Initialization
    init(model: [FeedElement]? = nil) {
        if let inputModel = model {
            feedElements = inputModel
        }
    }
    var feedElements = [FeedElement]()
    var title: String = "A & F"
}

extension ANFExploreCardTableViewModel {
    func fetchFeedElements(completion: @escaping (Result<[FeedElement], Error>) -> Void) {
        ExploreDataService().sampleDataElements { [unowned self] result in
            switch result {
            case .success(let elements):
                self.feedElements = elements
                completion(.success(feedElements))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
