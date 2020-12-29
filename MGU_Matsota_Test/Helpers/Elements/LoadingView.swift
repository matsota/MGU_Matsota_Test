//
//  LoadingView.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

final class LoadingView: UIView {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.alpha = 0
        return activityIndicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
        if activityIndicator.superview == nil {
            addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            activityIndicator.startAnimating()
        }
    }

    public func animate() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.alpha = 1
        }
    }
}

fileprivate struct Constants {
    /// an arbitrary tag id for the loading view, so it can be retrieved later without keeping a reference to it
    fileprivate static let loadingViewTag = 1001
}

/// Default implementation for UIViewController
extension Loadable where Self: UIViewController {
    
    func showLoadingView() {
        if view.viewWithTag(Constants.loadingViewTag) == nil {
            let loadingView = LoadingView()
            view.addSubview(loadingView)
            
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            loadingView.animate()
            loadingView.tag = Constants.loadingViewTag
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            if let loadingView = self.view.viewWithTag(Constants.loadingViewTag) {
                UIView.animate(withDuration: 0.3) {
                    loadingView.alpha = 0
                    self.view.layoutIfNeeded()
                } completion: { (_) in
                    loadingView.removeFromSuperview()
                }
            }
        }
    }
}
