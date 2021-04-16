//
//  CoinManager.swift
//  BitCoin
//
//  Created by Anshul Gupta on 15/04/21.
//

import Foundation


struct CoinManager{
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = ""
    let currencyArray = ["AUD","INR", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getURL(currency : String, coin:String) -> String {
        if coin == "BTC"{
            return baseURL + "BTC/" + currency + "?apikey=" + apiKey
        }else{
            return baseURL + "ETC/" + currency + "?apikey=" + apiKey

        }
        
    }

}
