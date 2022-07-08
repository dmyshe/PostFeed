//
//  PostDownloaderProtocol.swift
//  PosFeed
//
//  Created by Дмитро  on 07.07.2022.
//

import Foundation

protocol PostDownloaderProtocol {
    typealias PostsResult = (Result<Posts,PostError>) -> Void
    typealias PostDetailsResult = (Result<PostDetails,PostError>) -> Void
    func getAllPost(then completion: @escaping PostsResult)
    func getOnePost(by id: Int, then completion: @escaping PostDetailsResult)
}
