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
    let postID, timeStamp: Int
    let title, textContent: String
    let postImageUrlString: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeStamp = "timeshamp"
        case textContent = "text"
        case title
        case postImageUrlString = "postImage"
        case likesCount = "likes_count"
    }
}

extension PostDetail {
    var likesText: String {
        "❤️\(likesCount)"
    }
    
    var timeAgoText: String {
        calculateWhenPostWasSent()
    }
    
    private func calculateWhenPostWasSent() -> String {
        let oldDate = Date(timeIntervalSince1970: Double(timeStamp))
        let dateComponents = Date().calculateDiffBetweenCurrentDate(and: oldDate, in: [.second,.minute,.hour,.day,.month,.year])
        return  dateComponents.timeAgoText
    }
}


