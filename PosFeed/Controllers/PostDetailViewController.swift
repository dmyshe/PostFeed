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
    private let loader: ImageDataLoader = NatifeImageDataLoader()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func prepareUI() {
        guard let postDetail = postDetail, let url = URL(string: postDetail.postImageUrlString) else { return }
        
        loader.downloadImageData(with: url) { [weak self] result in
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

    private func setupLayout() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textContent.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        daysAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let defaultPadding: CGFloat = 20
        let imageHeight: CGFloat = 150
        
        let contentLayoutGuid = scrollView.contentLayoutGuide
        let scrollFrameLayoutGuid = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scrollFrameLayoutGuid.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollFrameLayoutGuid.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollFrameLayoutGuid.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollFrameLayoutGuid.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -defaultPadding),
            
            postImageView.topAnchor.constraint(equalTo: contentLayoutGuid.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentLayoutGuid.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentLayoutGuid.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentLayoutGuid.leadingAnchor, constant: defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentLayoutGuid.trailingAnchor, constant: -defaultPadding),
            
            textContent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textContent.leadingAnchor.constraint(equalTo: contentLayoutGuid.leadingAnchor, constant: defaultPadding),
            textContent.trailingAnchor.constraint(equalTo: contentLayoutGuid.trailingAnchor, constant: -defaultPadding),
                    
            stackView.topAnchor.constraint(equalTo: textContent.bottomAnchor, constant: defaultPadding),
            stackView.leadingAnchor.constraint(equalTo: contentLayoutGuid.leadingAnchor, constant: defaultPadding),

            stackView.trailingAnchor.constraint(equalTo: contentLayoutGuid.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentLayoutGuid.bottomAnchor, constant: -defaultPadding),
            
            
            daysAgoLabel.trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: -5),
            daysAgoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: likesLabel.trailingAnchor, constant: 5)
//
        ])
    }
}
