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
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}


extension Post {
    var likesText: String {
        "❤️\(likesCount)"
    }
    
    var timeAgoText: String {
        "10 day ago"
    }
    
    func calculateWhenPostWasSent(dateComponent: DateComponents... ) {
        let date = Date(timeIntervalSinceNow: Double(timeshamp))
        let currentDate = Date()
        let daysAgo = Calendar.current.dateComponents([.second,.minute,.hour,.month,.year], from: date, to: currentDate)
    }
}
