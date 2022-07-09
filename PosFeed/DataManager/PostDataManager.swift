//
//  PostDataManager.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

protocol PostDataManagerDelegate: AnyObject {
    func dataDownloaded()
    func reloadTableView()
}

final class PostDataManager {
    //MARK: - Enum
    enum PostSortType {
        case none,date,ratings
    }
    //MARK: - Property
    public var posts: [Post] = [] {
        didSet {
            delegate?.reloadTableView()
        }
    }
    //MARK: - Delegate
    public weak var delegate: PostDataManagerDelegate?
    
    private var postsArrayWithoutSorting: [Post] = []
    private var sortedPostArrayByRatings: [Post] = []
    private var sortedpostArrayByDate: [Post] = []
    
    private var currentSelectedPostArrayType: PostSortType = .none {
        didSet {
          checkCurrentSelectedPostArray()
        }
    }
    
   //MARK: - Methods
    public func getPosts(from postsArray: [Post]) {
        postsArrayWithoutSorting = postsArray
        currentSelectedPostArrayType = .none
        delegate?.dataDownloaded()
    }
    
    public func sort(by sortType: PostSortType) {
        switch sortType {
        case .none:
            currentSelectedPostArrayType = .none
        case .date:
            sortByDate()
            currentSelectedPostArrayType = .date
        case .ratings:
            sortByRatings()
            currentSelectedPostArrayType = .ratings
        }
    }
    
    
    private func sortByDate() {
        sortedpostArrayByDate = []
        
        sortedpostArrayByDate = postsArrayWithoutSorting.sorted {
            $0.timeshamp > $1.timeshamp
        }
    }
    
    private func sortByRatings() {
        sortedPostArrayByRatings = []
        
        sortedPostArrayByRatings = postsArrayWithoutSorting.sorted {
            $0.likesCount > $1.likesCount
        }
    }
    
    private func checkCurrentSelectedPostArray() {
        switch currentSelectedPostArrayType {
        case .none:
            posts = postsArrayWithoutSorting
        case .date:
            posts =  sortedpostArrayByDate
        case .ratings:
            posts =  sortedPostArrayByRatings
        }
    }
}
