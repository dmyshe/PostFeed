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
    
    //MARK: - Methods
    public func configure(with model: Post) {
        titleLabel.text = model.title
        likeLabel.text = model.likesText
        daysAgoLabel.text = model.timeAgoText
        print(model.previewText.count)
        setTextContent(with: model.previewText, isExpanded: model.isExpanded)
        setButtonTitle(with: model.isExpanded, hasMinimumPreviewText: model.hasMinimumPreviewText)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        textContent.text = nil
        likeLabel.text = nil
        daysAgoLabel.text = nil
        expandCollapseToogleButton.isHidden = false 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expandCollapseToogleButton.layer.cornerRadius = 10
    }
    
    //MARK: - IBActions
    @IBAction private func expandCollapseButtonPressed(_ sender: UIButton) {
        delegate?.expandCollapseButtonPressed(cell: self)
    }
    
    private func setButtonTitle(with isButtonPressed: Bool, hasMinimumPreviewText: Bool) {
        if !isButtonPressed && hasMinimumPreviewText {
            expandCollapseToogleButton.setTitle("Expand", for: .normal)
        } else if hasMinimumPreviewText {
            expandCollapseToogleButton.setTitle("Collapse", for: .normal)
        } else {
            expandCollapseToogleButton.isHidden = !hasMinimumPreviewText
        }
    }
    
    private func setTextContent(with text: String, isExpanded: Bool) {
        textContent.text = text
        textContent.numberOfLines = isExpanded ? 0 : 2
    }
}
