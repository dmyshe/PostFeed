//
//  PostDetail.swift
//  PosFeed
//
//  Created by Дмитро  on 07.07.2022.
//

import Foundation


struct PostDetails: Codable {
    let post: PostDetail
}

 struct PostDetail: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}

extension PostDetail {
    var likesText: String {
        "❤️\(likesCount)"
    }
    
    var timeAgoText: String {
        "10 day ago"
    }
    
    private func calculateWhenPostWasSent() {
        let time = calculateTimePost(in: [.second,.minute,.hour,.month,.year])
  
    }
    
    func calculateTimePost(in dateComponents: Set<Calendar.Component>) -> DateComponents {
        let date = Date(timeIntervalSinceNow: Double(timeshamp))
        let currentDate = Date()
        let daysAgo = Calendar.current.dateComponents(dateComponents, from: date, to: currentDate)
        
        return daysAgo
    }
}


