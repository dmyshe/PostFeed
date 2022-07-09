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
    //MARK: - Property
    private var postInfo = NatifePostInfo()
    private var session = URLSession.shared
    
    //MARK: - Methods
    public func getAllPost(then completion: @escaping PostsResult) {
        let url = postInfo.urlForGetAllPost
        let dataTask =  session.downloadAndDecodePostData(from: url, andSaveIn: completion)
        dataTask.resume()
    }
    
    public func getOnePost(by id: Int, then completion: @escaping PostDetailsResult) {
        postInfo.set(id)
        let url = postInfo.urlForGetOnePost
        let dataTask = session.downloadAndDecodePostData(from: url, andSaveIn: completion)
        dataTask.resume()
    }
}


fileprivate extension URLSession {
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
