//
//  Supply.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 20.10.2022.
//

import Foundation

struct Supply: Decodable {
    let annualInflationPercent: Double?
    
    enum CodingKeys: String, CodingKey {
        case annualInflationPercent = "annual_inflation_percent"
    }
}
