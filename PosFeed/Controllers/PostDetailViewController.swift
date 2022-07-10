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
        
        natifePostImageDownloader.downloadImageData(with: postDetail.postImage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.postImageView.image = UIImage(data: data)
                    self.postImageView.isHidden = false
                    
                    self.show(self.titleLabel, withText: postDetail.title)
                    self.show(self.textContent, withText: postDetail.textContent)
                    self.show(self.likesLabel, withText: postDetail.likesText)
                    self.show(self.daysAgoLabel, withText: postDetail.timeAgoText)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PostDetailViewController {
    private func show(_ label: UILabel, withText text: String) {
        label.text = text
        label.isHidden = false
    }

    private func setConstraints() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textContent.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.isDirectionalLockEnabled = false
        
        let defaultPadding: CGFloat = 20
        let imageHeight: CGFloat = 150
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -defaultPadding),
            
            postImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            postImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            postImageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: defaultPadding),
            titleLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -defaultPadding),
            
            textContent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: defaultPadding),
            textContent.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -defaultPadding),
                    
            stackView.topAnchor.constraint(equalTo: textContent.bottomAnchor, constant: defaultPadding),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: defaultPadding),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -defaultPadding),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -defaultPadding)
        ])
    }
}
