//
//  SceneDelegate.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let builder = MainBuilder()
        let mainRouter = MainRouter()
        window = UIWindow()
        window?.windowScene = scene
        let mainNavigationController = UINavigationController(rootViewController: builder.createAuthVC(mainRouter: mainRouter))
        mainRouter.initialViewControllers(mainNavigationController: mainNavigationController)
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {    }
    func sceneDidBecomeActive(_ scene: UIScene) {    }
    func sceneWillResignActive(_ scene: UIScene) {    }
    func sceneWillEnterForeground(_ scene: UIScene) {    }
    func sceneDidEnterBackground(_ scene: UIScene) {    }

    
}

