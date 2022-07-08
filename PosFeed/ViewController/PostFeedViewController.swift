//
//  PostFeedViewController.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import UIKit

class PostFeedViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortButton: UIBarButtonItem!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - DataManager
    var postDataManager = PostDataManager()
    
    //MARK: - Services
    private let natifePostDownloader: PostDownloaderProtocol = NatifePostsDownloader()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        postDataManager.delegate = self
        fetchData()
        prepareViews()
    }
    
    private func fetchData() {
        natifePostDownloader.getAllPost { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.postDataManager.getPosts(from: data.posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func prepareViews() {
        title = "Downloading..."
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

//MARK: - UITableViewDelegate
extension PostFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postID = postDataManager.posts[indexPath.row].postID
        
        natifePostDownloader.getOnePost(by: postID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let vc = self.createPostDetailVC()
                    vc.postDetail = data.post
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension PostFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postDataManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let post = postDataManager.posts[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
}

//MARK: - PostCellDelegate
extension PostFeedViewController: PostCellDelegate {
    func expandCollapseButtonPressed(cell: UITableViewCell) {
        if let cellIndex = tableView.indexPath(for: cell)?.row {
            print("cell - \(cellIndex)")
        }
    }
}

//MARK: - PostDataManagerDelegate
extension PostFeedViewController: PostDataManagerDelegate {
    func dataDownloaded() {
        DispatchQueue.main.async {
            self.title = "Posts"
            self.activityIndicator.stopAnimating()
            self.navigationItem.rightBarButtonItem = self.sortButton
            self.sortButton.menu = self.createMenuWithSortDateAndRatings()
            self.tableView.isHidden = false
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostFeedViewController {
    private func createMenuWithSortDateAndRatings() -> UIMenu {
        let noSorting = UIAction(title: "No sorting",
                                  image: .clockSystemIcon) { [weak self] _ in
            guard let self = self else { return }
            self.postDataManager.sort(by: .none)
        }
        
        
        let dateSorting = UIAction(title: "Sort by date",
                                image: .clockSystemIcon) { [weak self] _ in
            guard let self = self else { return }
            self.postDataManager.sort(by: .date)
        }
        
        let ratingSorting = UIAction(title: "Sort by ratings",
                                  image: .heartSystemIcon) { [weak self] action in
            guard let self = self else { return }
            self.postDataManager.sort(by: .ratings)
        }
        
        return UIMenu(children: [noSorting,dateSorting,ratingSorting])
    }
    
    private func createPostDetailVC() -> PostDetailViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        return vc
    }
}


fileprivate extension UIImage {
    static let clockSystemIcon = UIImage(systemName: "clock")
    static let heartSystemIcon = UIImage(systemName: "heart.fill")
}