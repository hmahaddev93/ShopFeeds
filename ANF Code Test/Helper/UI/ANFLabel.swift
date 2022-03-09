//
//  ANFLabel.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/8/22.
//

import UIKit

final class ANFLabel: UILabel {
    public init(size: CGFloat, isBold: Bool = false, alignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: size)
        }
        else {
            self.font = UIFont.systemFont(ofSize: size)
        }
        self.numberOfLines = 0
        self.textAlignment = alignment
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
