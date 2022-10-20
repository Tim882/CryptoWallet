//
//  MiningStats.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 20.10.2022.
//

import Foundation

struct MiningStats: Decodable {
    let miningAlgo: String?
    let miningRevenuePerHashPerSecondUSD: Double?
    
    enum CodingKeys: String, CodingKey {
        case miningAlgo = "mining_algo"
        case miningRevenuePerHashPerSecondUSD = "mining_revenue_per_hash_per_second_usd"
    }
}
