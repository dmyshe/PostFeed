//
//  NatifePostsImageDownloader.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

enum DownloadImageError: Error {
    case urlError
    case networkFailure(Error)
    case invalidData
}

final class NatifePostsImageDownloader {
    //MARK: - Property
    private var session = URLSession.shared

    //MARK: - Methods
    public func downloadImageData(with urlString: String,then completion: @escaping (Result< Data,DownloadImageError>) -> Void ) {
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
