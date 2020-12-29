//
//  UIImageView+.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    func rounding() -> Self {
        clipsToBounds = true
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        return self
    }
    
}
