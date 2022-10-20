//
//  CoinModel.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import Foundation

struct CoinsListElement: Decodable {
    let symbol: String
    let name: String
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case marketData = "market_data"
    }
}

struct Coin: Codable {
    let name: String
    let symbol: String
    let price: Double
    let change: Double
}
