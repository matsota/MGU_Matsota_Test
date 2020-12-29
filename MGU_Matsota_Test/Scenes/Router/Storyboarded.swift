//
//  Storyboarded.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {

    static func instantiate(from storyboard: UIStoryboard) -> Self {
        let storyboardIdentifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}
