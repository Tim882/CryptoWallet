//
//  CoinsListViewProtocol.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

extension CoinsListVC: CoinsListViewProtocol {
    
    func success() {
        coinsTable.reloadData()
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
        refreshControl.isHidden = true
    }
    
    func failure(error: String) {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
        refreshControl.isHidden = true
        alert.title = "Error"
        alert.message = error
        present(alert, animated: true)
    }
}
