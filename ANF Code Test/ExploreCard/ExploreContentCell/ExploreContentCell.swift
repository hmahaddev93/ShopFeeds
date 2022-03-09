//
//  ExploreContentCell.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/7/22.
//

import UIKit

class ExploreContentCell: UITableViewCell {
    
    var model: FeedElement? {
        didSet {
            stackView.removeFullyAllArrangedSubviews()
            addBackgroundImage()
            addTopDescription()
            addTitle()
            addPromoMessage()
            addSpacer()
            addBottomDescription()
            addButtons()
        }
    }
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel = ANFLabel(size: 17, isBold: true)
    let topDescLabel = ANFLabel(size: 13)
    let bottomDescLabel = ANFLabel(size: 13)
    let promoMessageLabel = ANFLabel(size: 11)
        
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Add content elements
    private func addBackgroundImage() {
        if let bgImageURL = model?.backgroundImage {
            backImageView.loadThumbnail(url: bgImageURL)
            stackView.addArrangedSubview(backImageView)
            
            let aspectRatio: CGFloat = 5.6 / 10
            
            NSLayoutConstraint.activate([
                backImageView.heightAnchor.constraint(equalTo: backImageView.widthAnchor, multiplier: aspectRatio)
            ])
            
            addSpacer()
        }
    }
    
    private func addTitle() {
        titleLabel.text = model?.title
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func addTopDescription() {
        if let topDesc = model?.topDescription {
            topDescLabel.text = topDesc
            stackView.addArrangedSubview(topDescLabel)
        }
    }
    
    private func addPromoMessage() {
        if let promo = model?.promoMessage {
            promoMessageLabel.text = promo
            stackView.addArrangedSubview(promoMessageLabel)
        }
    }
    
    private func addBottomDescription() {
        if let bottomDesc = model?.bottomDescription {
            bottomDescLabel.attributedText = bottomDesc.htmlToAttributedString
            stackView.addArrangedSubview(bottomDescLabel)
            
            addSpacer()
        }
    }
    
    private func addButtons() {
        if let feedContents = model?.content {
            
            var buttons = [UIView]()
            for buttonContent in feedContents {
                let button = ANFButton()
                button.setTitle(buttonContent.title, for: .normal)
                button.tag = buttons.count
                button.addTarget(self, action: #selector(onShopLinkButton(sender:)), for: .touchUpInside)
                buttons.append(button)
            }

            let buttonStack = UIStackView(arrangedSubviews: buttons)
            buttonStack.distribution = .fillEqually
            buttonStack.axis = .horizontal
            buttonStack.alignment = .center
            buttonStack.spacing = 12
            stackView.addArrangedSubview(buttonStack)
                        
            addSpacer()
        }
    }
    
    private func addSpacer() {
        let spacer = UIView()
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: 20)
        ])
        stackView.addArrangedSubview(spacer)
    }
    
    @objc func onShopLinkButton(sender: AnyObject) {
        if let url = model?.content?[sender.tag].target,
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
}
