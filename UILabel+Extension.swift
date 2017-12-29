//
//  UILabel+Extension.swift
//  SeeU Pay
//
//  Created by Johnny Wang on 2017/10/30.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setLetterSpacing(letterSpactig: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Letter spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.kern, value:letterSpactig, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
}
