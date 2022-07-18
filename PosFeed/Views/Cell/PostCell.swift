//
//  PostCell.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func expandCollapseButtonPressed(cell: UITableViewCell)
}

final class PostCell: UITableViewCell {
    static let reuseIdentifier = "PostCell"
    //MARK: - IBOultets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var daysAgoLabel: UILabel!
    @IBOutlet private weak var expandCollapseToogleButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    
    //MARK: - Delegate
    weak var delegate: PostCellDelegate?
    
    //MARK: - Methods
    public func configure(titleText: String,
                          previewText: String,
                          likesText: String,
                          timeAgoText: String,
                          isExpanded: Bool,
                          previewTextHasMinimumWordCount: Bool) {
        
        titleLabel.text = titleText
        likeLabel.text = likesText
        daysAgoLabel.text = timeAgoText
        setPreviewTextLabel(with: previewText,
                            isShowFullText: isExpanded,
                            previewTextHasMinimumWordCount: previewTextHasMinimumWordCount)
        checkButtonTitle(with: isExpanded,
                         previewTextHasMinimumWordCount:  previewTextHasMinimumWordCount)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        previewTextLabel.text = nil
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
    
    private func checkButtonTitle(with isButtonPressed: Bool, previewTextHasMinimumWordCount: Bool) {
        if !isButtonPressed && previewTextHasMinimumWordCount {
            expandCollapseToogleButton.setTitle("Expand", for: .normal)
        } else if previewTextHasMinimumWordCount {
            expandCollapseToogleButton.setTitle("Collapse", for: .normal)
        } else {
            expandCollapseToogleButton.isHidden = !previewTextHasMinimumWordCount
        }
    }
    
    private func setPreviewTextLabel(with text: String, isShowFullText: Bool, previewTextHasMinimumWordCount: Bool) {
        previewTextLabel.text = text
        previewTextLabel.numberOfLines = isShowFullText || !previewTextHasMinimumWordCount ? 0 : 2
    }
}
