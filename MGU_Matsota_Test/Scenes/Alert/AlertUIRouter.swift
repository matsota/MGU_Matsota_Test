//
//  AlertUIRouter.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

final class AlertUIRouter {
    
    //MARK: - Methods
    
    func `default`(from parent: UIViewController,
                   with configure: AlertConfiguration,
                   onDidDismiss: (() -> Void)? = nil) {
        let vc = AlertWithOK.instantiate(from: storyboard)

        vc.onDidDismiss = onDidDismiss
        vc.configure = configure

        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        parent.present(vc, animated: true)
    }
    //MARK: - Init
    init () {
        storyboard = UIStoryboard(name: "Alert", bundle: nil)
    }
    
    //MARK: - Private Implementation
    private let storyboard: UIStoryboard!
    
}
