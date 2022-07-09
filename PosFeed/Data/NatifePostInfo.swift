//
//  NatifePostInfo.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//
import Foundation


struct NatifePostInfo {
    //MARK: - Property
    public var urlForGetAllPost: URL {
        checkURL(with: urlStringForGetAllPost)!
    }
    
    public var urlForGetOnePost: URL {
        checkURL(with: urlStringForGetOnePost)!
    }
    
    private var urlStringForGetAllPost: String {
        "\(baseUrl)/main.json"
    }
    private var urlStringForGetOnePost: String {
        "\(baseUrl)/posts/\(postID).json"
    }
    
    private var postID: Int = 0
    private let baseUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api"
    
    //MARK: - Methods
    public mutating func set(_ id: Int) {
        postID = id
    }
    
    private func checkURL(with urlString: String) -> URL? {
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
