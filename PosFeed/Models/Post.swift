//
//  Post.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

struct Posts: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let postID, timeStamp: Int
    let title, previewText: String
    let likesCount: Int
    
    var isExpanded = false
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeStamp = "timeshamp"
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}

extension Post {
    var likesText: String {
        "❤️\(likesCount)"
    }
    
    var timeAgoText: String {
        calculateWhenPostWasSent()
    }
    
    var previewTextHasMinimumWordCount: Bool {
        previewText.count > 90
    }

    private func calculateWhenPostWasSent() -> String {
        let oldDate = Date(timeIntervalSince1970: Double(timeStamp))
        let dateComponents = Date().calculateDiffBetweenCurrentDate(and: oldDate, in: [.second,.minute,.hour,.day,.month,.year])
        return  dateComponents.timeAgoText
    }
}
