//
//  CoinsListTableViewDelegate.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

extension CoinsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinName = presenter?.coins[indexPath.section].symbol {
            presenter?.showCoinInfo(coin: coinName)
        }
    }
}
