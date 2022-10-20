//
//  CoinIfoViewProtocol.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 06.10.2022.
//

import UIKit

extension CoinInfoVC: CoinInfoViewProtocol {
    func success() {
        contentTable.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
    func failure(error: String) {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
        alert.title = "Error"
        alert.message = error
        present(alert, animated: true)
    }
}
