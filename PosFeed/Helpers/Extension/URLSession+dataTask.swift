//
//  URLSession+dataTask.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation


extension URLSession {
    /// Creates a task that retrieves the contents of the specified URL, then calls a result handler upon completion.
    func dataTask(with url: URL,handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}



