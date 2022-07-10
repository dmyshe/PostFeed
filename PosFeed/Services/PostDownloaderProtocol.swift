//
//  PostDownloaderProtocol.swift
//  PosFeed
//
//  Created by Дмитро  on 07.07.2022.
//

import Foundation

protocol PostDownloaderProtocol {
    typealias PostsHandler = (Result<Posts,PostError>) -> Void
    typealias PostDetailHandler = (Result<PostDetails,PostError>) -> Void
    func getAllPost(then completion: @escaping PostsHandler)
    func getOnePost(by id: Int, then completion: @escaping PostDetailHandler)
}
