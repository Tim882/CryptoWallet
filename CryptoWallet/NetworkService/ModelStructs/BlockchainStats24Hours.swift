//
//  BlockchainStats24Hours.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 20.10.2022.
//

import Foundation

struct BlockchainStats24Hours: Decodable {
    let transactionVolume: Double?
    let countOfActiveAddresses: Int?
    
    enum CodingKeys: String, CodingKey {
        case transactionVolume = "transaction_volume"
        case countOfActiveAddresses = "count_of_active_addresses"
    }
}
