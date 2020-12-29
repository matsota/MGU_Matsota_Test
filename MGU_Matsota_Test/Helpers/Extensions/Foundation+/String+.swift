//
//  String+.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 29.12.2020.
//

import UIKit

//MARK: - Stylization
extension String {
    
    /// - Highlight some `attributedText`
    func stylizeFrom(attribute configuration: TextAttributeConfiguration) -> NSMutableAttributedString {
        let startedBy = configuration.startedFrom ?? ""
        let endedBy   = configuration.endedBy ?? ""
        
        let allString: String = startedBy + self + endedBy
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.0
        
        let additionalTextAttributes: [NSAttributedString.Key : Any] =
            [.font : UIFont.systemFont(ofSize: 8, weight: .medium),
             .paragraphStyle : paragraphStyle, .foregroundColor: UIColor.label]
        
        let selfTextAttributes: [NSAttributedString.Key : Any] =
            [.font : UIFont.systemFont(ofSize: 10, weight: .semibold),
             .foregroundColor: UIColor.label]
        
        let result = NSMutableAttributedString(string: allString,
                                               attributes: additionalTextAttributes)
        
        result.addAttributes(selfTextAttributes,
                             range: NSMakeRange(startedBy.count, self.count))
        return result
    }
    
}
