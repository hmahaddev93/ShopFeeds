//
//  HTTPClient.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/7/22.
//

import Foundation

final class HTTPClient {
    static let shared: HTTPClient = HTTPClient()

    enum HTTPError: Error {
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        .resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        get(url: url) { result in
                switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            case .success(let data):
                DispatchQueue.main.async() {
                    completion(.success(data))
                }
            }
        }
    }
}

