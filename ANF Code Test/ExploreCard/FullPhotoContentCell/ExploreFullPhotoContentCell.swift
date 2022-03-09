//
//  ExploreFullPhotoContentCell.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/8/22.
//

import UIKit

class ExploreFullPhotoContentCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    var model: FeedElement? {
        didSet {
            if let bgImageURL = model?.backgroundImage {
                bgImageView.loadThumbnail(url: bgImageURL)
            }
            addButtons()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func addButtons() {
        buttonStack.removeFullyAllArrangedSubviews()
        if let feedContents = model?.content {
            
            var idx = 0
            for buttonContent in feedContents {
                let button = ANFButton(borderColor: .clear, backgroundColor: .anfWhiteButtonBg)
                button.setTitle(buttonContent.title, for: .normal)
                button.tag = idx
                button.addTarget(self, action: #selector(onShopLinkButton(sender:)), for: .touchUpInside)
                buttonStack.addArrangedSubview(button)
                idx += 1
            }
        }
    }
    
    @objc func onShopLinkButton(sender: AnyObject) {
        if let url = model?.content?[sender.tag].target,
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
}
