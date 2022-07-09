//
//  PostCell.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

import UIKit


protocol PostCellDelegate: AnyObject {
    func expandCollapseButtonPressed(cell: UITableViewCell)
}

final class PostCell: UITableViewCell {
    static let reuseIdentifier = "PostCell"
    //MARK: - IBOultets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textContent: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var daysAgoLabel: UILabel!
    @IBOutlet private weak var expandCollapseToogleButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
        
    //MARK: - Delegate
    weak var delegate: PostCellDelegate?
    
    //MARK: - Property
    private var isButtonPressed = false
    
    //MARK: - Methods
    public func configure(with model: Post) {
        titleLabel.text = model.title
        textContent.text = model.previewText
        likeLabel.text = model.likesText
        daysAgoLabel.text = model.timeAgoText
        expandCollapseToogleButton.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        textContent.text = nil
        likeLabel.text = nil
        daysAgoLabel.text = nil
    }
    
    //MARK: - IBActions
    @IBAction private func expandCollapseButtonPressed(_ sender: UIButton) {
        if isButtonPressed {
            expandCollapseToogleButton.setTitle("Collapse", for: .normal)
        } else {
            expandCollapseToogleButton.setTitle("Expand", for: .normal)
        }
        
        isButtonPressed.toggle()
        
        delegate?.expandCollapseButtonPressed(cell: self)
    }
}
