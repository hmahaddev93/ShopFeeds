//
//  ANFButton.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/8/22.
//

import UIKit

final class ANFButton: UIButton {
    public init(size: CGFloat = 15, isBold: Bool = false, borderColor: UIColor = .black, backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        
        setTitleColor(.black, for: .normal)
        if isBold {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: size)
        }
        else {
            self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        }
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
