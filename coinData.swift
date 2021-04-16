//
//  coinData.swift
//  BitCoin
//
//  Created by Anshul Gupta on 16/04/21.
//

import Foundation


struct CoinData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
}
