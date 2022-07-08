//
//  PostDetailViewController.swift
//  PosFeed
//
//  Created by Дмитро  on 08.07.2022.
//

import Foundation
import UIKit

class PostDetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textContent: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var daysAgoLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    
    public var postDetail:  PostDetail? {
        didSet {
            prepareUI()
        }
    }
    //MARK: - Services
    private let natifePostImageDownloader = NatifePostsImageDownloader()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    private func prepareUI() {
        guard let postDetail = postDetail else { return }
        
        natifePostImageDownloader.downloadImageData(with: postDetail.postImage) { [weak self]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.postImageView.image = UIImage(data: data)
                    self.postImageView.isHidden = false
                    
                    self.show(self.titleLabel, withText: postDetail.title)
                    self.show(self.textContent, withText: postDetail.text)
                    self.show(self.likesLabel, withText: "❤️\(postDetail.likesCount)")
                    self.show(self.daysAgoLabel, withText: "1 day ago")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func show(_ label: UILabel, withText text: String) {
        label.text = text
        label.isHidden = false
    }
}

extension PostDetailViewController {
    private func setConstraints() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textContent.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.isDirectionalLockEnabled = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            postImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            postImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            postImageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
//            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            textContent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            textContent.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
                    
            stackView.topAnchor.constraint(equalTo: textContent.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)

        ])
    }
}
