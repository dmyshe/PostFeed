//
//  NatifePostsImageDownloader.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

final class NatifePostsImageDownloader {
    private var session = URLSession.shared

    public func downloadImageData(with urlString: String,then completion: @escaping (Result< Data,PostError>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.networkFailure(error)))
            }
        }
        task.resume()
    }
}
