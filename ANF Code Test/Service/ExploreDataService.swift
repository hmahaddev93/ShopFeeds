//
//  ExploreDataService.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/7/22.
//

import Foundation

enum ExploreDataAPI  {
    static let sampleDataUrl = URL(string: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json")!
}

enum ExploreDataServiceError: Error {
    case invalidURL
    case emptyData
}

protocol ExploreDataService_Protocol {
    func sampleDataElements(completion: @escaping (Result<[FeedElement], Error>) -> Void)
}

final class ExploreDataService: ExploreDataService_Protocol {

    private let httpClient: HTTPClient
    private let jsonDecoder: JSONDecoder
    
    init(httpClient: HTTPClient = HTTPClient.shared) {
        self.httpClient = httpClient
        self.jsonDecoder = JSONDecoder()
    }
    
    func sampleDataElements(completion: @escaping (Result<[FeedElement], Error>) -> Void) {
        httpClient.get(url: ExploreDataAPI.sampleDataUrl) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let result = try self.jsonDecoder.decode([FeedElement].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

