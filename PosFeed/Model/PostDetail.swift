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

