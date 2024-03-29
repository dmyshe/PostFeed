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
    private let postDataManager = PostDataManager()
    
    //MARK: - Services
    private let loader: PostLoader = NatifePostLoader()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloading..."
        postDataManager.delegate = self
        fetchData()
        setupTableView()
    }
    
    private func fetchData() {
        loader.downloadAllPost { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.postDataManager.getPosts(from: data.posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 230
    }
}

//MARK: - UITableViewDelegate
extension PostFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postID = postDataManager.posts[indexPath.row].postID
        
        let detailVC = createPostDetailVC()
        navigationController?.pushViewController(detailVC, animated: true)

        loader.downloadOnePost(by: postID) {  result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    detailVC.postDetail = data.post
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        
        let post = postDataManager.posts[indexPath.row]
        
        cell.configure(titleText: post.title,
                       previewText: post.previewText,
                       likesText: post.likesText,
                       timeAgoText: post.timeAgoText,
                       isExpanded: post.isExpanded,
                       previewTextHasMinimumWordCount: post.previewTextHasMinimumWordCount)
        
        cell.delegate = self
        
        return cell
    }
}

//MARK: - PostCellDelegate
extension PostFeedViewController: PostCellDelegate {
    func expandCollapseButtonPressed(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let row = indexPath.row
            postDataManager.posts[row].isExpanded.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
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
            self.tableView.reloadData()
        }
    }
    
    func postsChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostFeedViewController {
    private func createMenuWithSortDateAndRatings() -> UIMenu {
        let noSorting = UIAction(title: "No sorting", image: .clockSystemIcon) { [weak self] _ in
            guard let self = self else { return }
            self.postDataManager.sort(by: .none)
        }

        let dateSorting = UIAction(title: "Sort by date", image: .clockSystemIcon) { [weak self] _ in
            guard let self = self else { return }
            self.postDataManager.sort(by: .date)
        }
        
        let ratingSorting = UIAction(title: "Sort by ratings", image: .heartSystemIcon) { [weak self] action in
            guard let self = self else { return }
            self.postDataManager.sort(by: .ratings)
        }
        
        return UIMenu(children: [noSorting,dateSorting,ratingSorting])
    }
    
    private func createPostDetailVC() -> PostDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        return vc
    }
}


fileprivate extension UIImage {
    static let clockSystemIcon = UIImage(systemName: "clock")
    static let heartSystemIcon = UIImage(systemName: "heart.fill")
}
