//
//  CoinsListPresenter.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import Foundation

protocol CoinsListViewProtocol: AnyObject {
    func success()
    func failure(error: String)
}

protocol CoinsListPresenterProtocol {
    var coins: [Coin] { get set }
    var view: CoinsListViewProtocol? { get }
    var coinNames: [String] { get }
    init(view: CoinsListViewProtocol,
         router: MainRouterProtocol,
         networkService: NetworkServiceProtocol)
    func logOut()
    func getCoins()
    func sortCoins(isAccending: Bool)
    func showCoinInfo(coin: String)
}

final class CoinsListPresenter: CoinsListPresenterProtocol {
    
    var coins: [Coin]
    private var errorCoins: [String]
    private(set) weak var view: CoinsListViewProtocol?
    private var router: MainRouterProtocol
    private var networkService: NetworkServiceProtocol
    var coinNames: [String]
    
    init(view: CoinsListViewProtocol,
         router: MainRouterProtocol,
         networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        coins = [Coin]()
        coinNames = ["btc", "eth", "tron", "luna",
                     "polkadot", "dogecoin", "tether",
                     "stellar", "cardano", "xrp"]
        errorCoins = []
    }
    
    // MARK: - Log Out
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "Login")
        UserDefaults.standard.removeObject(forKey: "Password")
        router.showAuthVC()
    }
    
    // MARK: - Get Coins
    func getCoins() {
        var networkCoins = [Coin]()
        errorCoins = []
        let coinsGroup = DispatchGroup()
        for name in coinNames {
            coinsGroup.enter()
            networkService.getCoinInfo(coin: name) { (result: Result<NetworkModel, Error>) in
                switch result {
                case .success(let coinNetworkModel):
                    let coin = Coin(name: coinNetworkModel.data.name,
                                    symbol: coinNetworkModel.data.symbol,
                                    price: coinNetworkModel.data.marketData.priceUSD ?? 0.0,
                                    change: coinNetworkModel.data.marketData.percentChangeUSDLast24Hours ?? 0.0)
                    networkCoins.append(coin)
                case .failure(let error):
                    self.errorCoins.append(name)
                    print(error.localizedDescription)
                }
                coinsGroup.leave()
            }
        }

        coinsGroup.notify(queue: DispatchQueue.main) {
            self.coins = networkCoins
            self.view?.success()
            if !self.errorCoins.isEmpty {
                let coinsListString = self.errorCoins.reduce("") { partialResult, name in
                    return partialResult + "\n" + name
                }
                self.view?.failure(error: "Could not download info for coins: \(coinsListString)")
            }
        }
    }
    
    // MARK: - Sort Coins
    func sortCoins(isAccending: Bool) {
        if isAccending {
            coins = coins.sorted(by: { $0.change < $1.change })
        } else {
            coins = coins.sorted(by: { $0.change > $1.change })
        }
    }
    
    // MARK: - Show Coin Info
    func showCoinInfo(coin: String) {
        router.showCoinInfo(coin: coin)
    }
}
