//
//  CoinsListTableViewDataSource.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

extension CoinsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.coins.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinsTable.dequeueReusableCell(withIdentifier: "CoinDefault") as? CoinCell,
              let coin = presenter?.coins[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setUpInfo(name: coin.name,
                       price: String(coin.price),
                       change: String(coin.change),
                       isPositiveChange: coin.change > 0)
        
        return cell
    }
}
