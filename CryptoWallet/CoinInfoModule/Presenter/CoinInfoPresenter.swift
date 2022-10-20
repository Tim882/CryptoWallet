//
//  CoinInfoPresenter.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 06.10.2022.
//

import Foundation

protocol CoinInfoViewProtocol: AnyObject {
    func success()
    func failure(error: String)
}

protocol CoinInfoPresenterProtocol {
    var view: CoinInfoViewProtocol? { get }
    var coinName: String { get set }
    var coinInfo: CoinsListExtendedElement? { get }
    init(router: MainRouterProtocol,
         networService: NetworkServiceProtocol,
         view: CoinInfoViewProtocol,
         coinName: String)
    func getCoinInfo()
    func logOut()
    func getString<T: LosslessStringConvertible>(value: T?, tail: String) -> String
}

final class CoinInfoPresenter: CoinInfoPresenterProtocol {
    
    private var router: MainRouterProtocol
    private var networService: NetworkServiceProtocol
    private(set) weak var view: CoinInfoViewProtocol?
    var coinInfo: CoinsListExtendedElement?
    var coinName: String
    
    init(router: MainRouterProtocol,
         networService: NetworkServiceProtocol,
         view: CoinInfoViewProtocol,
         coinName: String) {
        self.router = router
        self.networService = networService
        self.view = view
        self.coinName = coinName
    }
    
    // MARK: - Get Coin Info
    func getCoinInfo() {
        networService.getCoinInfo(coin: coinName) { (result: Result<NetworkExtendedModel, Error>) in
            switch result {
            case .success(let coinInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.coinInfo = coinInfo.data
                    self?.view?.success()
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    if let networkError = error as? NetworkErrors,
                       networkError == .statusCodeError {
                        self?.view?.failure(error: "Something went wrong. Please try again later.")
                    } else {
                        self?.view?.failure(error: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "Login")
        UserDefaults.standard.removeObject(forKey: "Password")
        router.showAuthVC()
    }
    
    func getString<T: LosslessStringConvertible>(value: T?, tail: String = "") -> String {
        if let value = value {
            return String(value) + tail
        } else {
            return "no info"
        }
    }
}
