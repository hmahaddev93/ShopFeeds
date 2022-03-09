//
//  FeedElement.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/7/22.
//

import Foundation

enum FeedType: Int, CaseIterable {
    case fullItem
    case fullPhotoItem
}

struct FeedElement: Codable {
    let title: String
    let backgroundImage: URL?
    let topDescription: String?
    let bottomDescription: String?
    let promoMessage: String?
    let content: [FeedElementContent]?
    
    var feedType: FeedType {
        if self.topDescription != nil {
            return .fullItem
        } else {
            return .fullPhotoItem
        }
    }
}

struct FeedElementContent: Codable {
    let title: String
    let target: URL?
    let elementType: String?
}
