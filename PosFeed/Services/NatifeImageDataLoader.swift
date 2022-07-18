//
//  NatifeImageDataLoader.swift
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

final class NatifeImageDataLoader: ImageDataLoader {
    //MARK: - Properties
    private let session = URLSession.shared

    //MARK: - Methods
    /// Download image date from URL
    public func downloadImageData(with url: URL ,then completion: @escaping DataHandler) {
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
