//
//  String+HTML.swift
//  ANF Code Test
//
//  Created by Khateeb H. on 3/8/22.
//

import UIKit

extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attrStr = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            let centerStyle = NSMutableParagraphStyle()
            centerStyle.alignment = .center
            attrStr.addAttribute(.paragraphStyle, value: centerStyle, range: NSMakeRange(0, attrStr.length))
            
            return attrStr
            
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
