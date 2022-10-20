//
//  CoinInfoDatasource.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 06.10.2022.
//

import UIKit

extension CoinInfoVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Symbol"
        } else if section == 1 {
            return "Market data"
        } else if section == 2 {
            return "Supply"
        } else if section == 3 {
            return "Blockchain stats"
        } else if section == 4 {
            return "Mining stats"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 2
        } else if section == 4 {
            return 2
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let presenter = presenter,
              let coinInfo = presenter.coinInfo else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell()
        
        var configuration = cell.defaultContentConfiguration()
        
        var content = ""
        
        if indexPath.section == 0 {
            content = coinInfo.symbol
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                content = "Price: " + presenter.getString(value: coinInfo.marketData.priceUSD, tail: "$")
            } else if indexPath.row == 1 {
                content = "Change USD last 24 hours: " + presenter.getString(value: coinInfo.marketData.percentChangeUSDLast24Hours, tail: " %")
            }
        } else if indexPath.section == 2 {
            content = "Annual inflation: " + presenter.getString(value: coinInfo.supply.annualInflationPercent, tail: " %")
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                content = "Count of active addresses: " + presenter.getString(value: coinInfo.blockchainStats24Hours.countOfActiveAddresses, tail: "")
            } else if indexPath.row == 1 {
                content = "Transaction volume: " + presenter.getString(value: coinInfo.blockchainStats24Hours.transactionVolume, tail: "")
            }
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                content = "Mining algorithm: " + (coinInfo.miningStats.miningAlgo ?? "no info")
            } else if indexPath.row == 1 {
                content = "Mining revenue per hash per second: " + presenter.getString(value: coinInfo.miningStats.miningRevenuePerHashPerSecondUSD, tail: "$")
            }
        }
        
        configuration.text = content
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}
