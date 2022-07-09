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
        calculateWhenPostWasSent()
    }
    
    func calculateTimePost(in dateComponents: Set<Calendar.Component>) -> DateComponents {
        print(timeshamp)
        let date = Date(timeIntervalSince1970: Double(timeshamp))
        let currentDate = Date()
        let daysAgo = Calendar.current.dateComponents(dateComponents, from: date, to: currentDate)
        
        return daysAgo
    }
    
    private func calculateWhenPostWasSent() -> String {
        let dateComponents = calculateTimePost(in: [.second,.minute,.hour,.day,.month,.year])
        return  dateComponents.timeAgoText
    }
}
