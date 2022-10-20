//
//  CoinInfoModule.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 06.10.2022.
//

import Foundation

struct CoinsListExtendedElement: Decodable {
    var symbol: String
    var marketData: MarketData
    var supply: Supply
    var blockchainStats24Hours: BlockchainStats24Hours
    var miningStats: MiningStats
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case marketData = "market_data"
        case supply
        case blockchainStats24Hours = "blockchain_stats_24_hours"
        case miningStats = "mining_stats"
    }
}
