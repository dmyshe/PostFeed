//
//  PostLoader.swift
//  PosFeed
//
//  Created by Дмитро  on 07.07.2022.
//

import Foundation

protocol PostLoader {
    typealias PostsHandler = (Result<Posts,PostError>) -> Void
    typealias PostDetailHandler = (Result<PostDetails,PostError>) -> Void
    
    func downloadAllPost(then completion: @escaping PostsHandler)
    func downloadOnePost(by id: Int, then completion: @escaping PostDetailHandler)
}
