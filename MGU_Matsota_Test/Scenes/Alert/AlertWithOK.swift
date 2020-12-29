//
//  AlertWithOKViewController.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

final class AlertWithOK: UIViewController, Storyboarded {
    
    //MARK: - Implementation
    public var onDidDismiss: (() -> Void)?
    public var configure: AlertConfiguration?
//    public var alertTitle: String?
//    public var alertBody: String?
//    public var color: UIColor?

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - View
        alertView.clipsToBounds = true
        alertView.backgroundColor = .clear
        
        /// - ImageView
        xMarkImageView.tintColor = configure?.color
        
        /// - Label
        titleLabel.text = configure?.alertTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        bodyLabel.text = configure?.alertBody
        bodyLabel.font = UIFont.systemFont(ofSize: 24, weight: .thin)

        labelCollection.forEach { (label) in
            let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissByLabel(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(dismissGesture)
            label.textColor = configure?.color
        }
        
        /// - Button
        dismissButton.addBlurEffect()
        
    }

    //MARK: - Private Actions
    @IBAction private func dismissAction(_ sender: Any) {
        dismiss(animated: true) {
            self.onDidDismiss?()
        }
    }
    
    //MARK: - Private Implementation
    
    /// - View
    @IBOutlet private weak var alertView: UIView!
    
    /// - ImageView
    @IBOutlet private weak var xMarkImageView: UIImageView!
    
    /// - Label
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private var labelCollection: [UILabel]!
    
    /// - Button
    @IBOutlet private weak var dismissButton: UIButton!
}









//MARK: - Private Methods
private extension AlertWithOK {
    
    @objc func dismissByLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
