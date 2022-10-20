//
//  MarketData.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 20.10.2022.
//

import Foundation

struct MarketData: Decodable {
    let priceUSD: Double?
    let percentChangeUSDLast24Hours: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case percentChangeUSDLast24Hours = "percent_change_usd_last_24_hours"
    }
}
