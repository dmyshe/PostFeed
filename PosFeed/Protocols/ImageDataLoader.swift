//
//  ImageDataLoader.swift
//  PostFeed
//
//  Created by Дмитро  on 14.07.2022.
//

import Foundation

protocol ImageDataLoader {
    typealias DataHandler = (Result<Data,DownloadImageError>) -> Void
    func downloadImageData(with url: URL ,then completion: @escaping DataHandler)
}
