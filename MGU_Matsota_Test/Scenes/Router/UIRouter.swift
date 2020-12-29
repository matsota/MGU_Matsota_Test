//
//  UIRouter.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

final class UIRouter {

    //MARK: - Implementation
    public var window: UIWindow!
    public static var instance: UIRouter!
    
    /// - Subrouters
    ///
    /// - Common
    /// `alert` router. Contains different types of alert view controllers
    public lazy var alert: AlertUIRouter = {
        return AlertUIRouter()
    }()
    
    //MARK: - Init
    init(_ appDelegate: AppDelegate, _ networkManager: NetworkManager) {
        self.networkManager = networkManager

        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        window = appDelegate.window

        UIRouter.instance = self
    }
    
    //MARK: - Private Implementation
    private var networkManager: NetworkManager
    private var mainStoryboard: UIStoryboard
}









//MARK: - Public Methods
extension UIRouter {
    
    /// Entering in main application features
    public func enter() {
        if let scene = UIApplication.shared.connectedScenes.first,
           let windowScene = (scene as? UIWindowScene) {
            let vc = MainViewController.instantiate(from: mainStoryboard)
            vc.networkManager = networkManager
            
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.navigationItem.setHidesBackButton(false, animated: true)
            navigationController.setNavigationBarHidden(false, animated: true)
            navigationController.navigationBar.tintColor = .white
            navigationController.navigationBar.standardAppearance.backgroundColor = Colors.navigationBarBackgroundColor.value
            
            window.windowScene = windowScene
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
}

