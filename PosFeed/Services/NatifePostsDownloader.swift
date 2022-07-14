//
//  NatifePostsDownloader.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//
import Foundation

enum PostError: Error {
    case urlError
    case networkFailure(Error)
    case invalidData
}

final class NatifePostsDownloader: PostDownloaderProtocol  {
    //MARK: - Properties
    private var postInfo = NatifePostInfo()
    private let session = URLSession.shared
    
    //MARK: - Methods
    /// Download all post.
    public func getAllPost(then completion: @escaping PostsHandler) {
        let url = postInfo.urlForGetAllPost
        let dataTask = session.downloadAndDecodePostData(from: url, andSaveIn: completion)
        dataTask.resume()
    }
    /// Download one post by id.
    public func getOnePost(by id: Int, then completion: @escaping PostDetailHandler) {
        postInfo.set(id)
        let url = postInfo.urlForGetOnePost
        let dataTask = session.downloadAndDecodePostData(from: url, andSaveIn: completion)
        dataTask.resume()
    }
}


fileprivate extension URLSession {
   /// Download and decode post date and store in completion.
    func downloadAndDecodePostData<T: Decodable>(from url: URL, andSaveIn completion:  @escaping (Result<T,PostError>) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let post = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(post))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                completion(.failure(.networkFailure(error)))
            }
        }
        return task
    }
}
