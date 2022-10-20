//
//  ModulesBuilder.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

protocol MainBuilderProtocol {
    func createAuthVC(mainRouter: MainRouterProtocol) -> UIViewController
    func createCoinsListVC(mainRouter: MainRouterProtocol) -> UIViewController
    func createCoinInfoVC(mainRouter: MainRouterProtocol, coinName: String) -> UIViewController
}

final class MainBuilder: MainBuilderProtocol {
    
    func createAuthVC(mainRouter: MainRouterProtocol) -> UIViewController {
        let view = AuthVC()
        let presenter = AuthPresenter(view: view, router: mainRouter)
        
        view.presenter = presenter
        
        return view
    }
    
    func createCoinsListVC(mainRouter: MainRouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = CoinsListVC()
        let presenter = CoinsListPresenter(view: view, router: mainRouter, networkService: networkService)
        
        view.presenter = presenter
        
        return view
    }
    
    func createCoinInfoVC(mainRouter: MainRouterProtocol, coinName: String) -> UIViewController {
        let networkService = NetworkService()
        let view = CoinInfoVC()
        let presenter = CoinInfoPresenter(router: mainRouter,
                                          networService: networkService,
                                          view: view,
                                          coinName: coinName)
        
        view.presenter = presenter
        
        return view
    }
}
