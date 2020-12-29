//
//  MainCollectionReusableView.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

class MainCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Implementation
    static let identifier = "MainCollectionReusableView"
    
    public func configure(title key: String?) {
        guard let key = key,
              let category = Categories.Keys(rawValue: key) else {return}
        let value = Categories(category)
        
        let label = UILabel()
        label.frame = frame
        label.text = value.localizedDescription
        label.font = .systemFont(ofSize: 30, weight: .thin)
        addSubview(label)
    }
        
}
