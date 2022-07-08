//
//  NatifePostInfo.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//
import Foundation


struct NatifePostInfo {
    public var urlStringForGetAllPost: String {
        "\(baseUrl)/main.json"
    }
    public var urlStringForGetOnePost: String {
        "\(baseUrl)/posts/\(postID).json"
    }
   
    private var postID: Int = 0
    private let baseUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api"
    
    mutating func set(_ id: Int) {
        postID = id
    }
}
