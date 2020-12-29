//
//  LabelDefaults.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 29.12.2020.
//

import UIKit

class LabelDefaults: UILabel {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

}









//MARK: - Public mathods
extension LabelDefaults {
    
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    public func isLoading(_ statement: Bool = true) -> Self {
        loading(statement)
        return self
    }
}

//MARK: - Private methods
private extension LabelDefaults {
    
    func setupAppearance() {
        self.numberOfLines = 0
        self.minimumScaleFactor = 0.1
        self.adjustsFontSizeToFitWidth = true
    }
    
    /// - `loading` and `removeLoading` methods. Must be last in stack
    func loading(_ statement: Bool) {
        let placeholderLayer = "PlaceholderLayer"
        let width = frame.width / 2
        let height = frame.height / 2
        switch statement {
        case true:
            let layer = CALayer()
            layer.name = placeholderLayer
            layer.backgroundColor = UIColor.placeholderText.withAlphaComponent(0.1).cgColor
            layer.frame = CGRect(x: 0, y: height - height / 2, width: width, height: height)
            self.layer.addSublayer(layer)
            textColor = UIColor.clear
            
        case false:
            layer.sublayers != nil ?
                layer.sublayers?.removeAll(where: {$0.name == placeholderLayer}) : ()
            textColor = .label
        }
    }
    
}
