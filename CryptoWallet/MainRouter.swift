//
//  MainRouter.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func initialViewControllers(mainNavigationController: UINavigationController)
    func showCoinsVC()
    func showCoinInfo(coin: String)
    func showAuthVC()
}

final class MainRouter: MainRouterProtocol {
    
    private var mainNavigationController: UINavigationController?
    
    func initialViewControllers(mainNavigationController: UINavigationController) {
        self.mainNavigationController = mainNavigationController
    }
    
    private func changeRootViewController(vc: UIViewController) {
        mainNavigationController?.viewControllers = [vc]
    }
    
    func showCoinsVC() {
        changeRootViewController(vc: MainBuilder().createCoinsListVC(mainRouter: self))
    }
    
    func showCoinInfo(coin: String) {
        mainNavigationController?.pushViewController(MainBuilder().createCoinInfoVC(mainRouter: self, coinName: coin), animated: true)
    }
    
    func showAuthVC() {
        changeRootViewController(vc: MainBuilder().createAuthVC(mainRouter: self))
    }
}
