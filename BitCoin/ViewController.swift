//
//  ViewController.swift
//  BitCoin
//
//  Created by Anshul Gupta on 15/04/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var etcRates: UILabel!
    
    @IBOutlet weak var etcCurrencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    let progressHUD = ProgressHUD(text: "Fetching")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    let coinManager = CoinManager()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var url = coinManager.getURL(currency: coinManager.currencyArray[row], coin: "BTC")
        self.view.addSubview(progressHUD)
        
        perfromRequest(urlString: url, coin: "BTC")
        url = coinManager.getURL(currency: coinManager.currencyArray[row], coin: "ETC")
        perfromRequest(urlString: url, coin: "ETC")
        
    }
    
    func perfromRequest(urlString: String, coin:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print("error")
                }
                if let safeData = data {
                    print("success block")
                    self.parseCoinData(coinData: safeData, coin: coin)
                }
            }
            task.resume()
            
        }
        
    }
    
    func parseCoinData(coinData: Data, coin:String){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            DispatchQueue.main.async {
                if coin == "BTC"{
                    self.bitcoinLabel.text = String(format: "%f", decodedData.rate )
                    self.currencyLabel.text = decodedData.asset_id_quote
                }else{
                    self.etcRates.text = String(format: "%f", decodedData.rate )
                    self.etcCurrencyLabel.text = decodedData.asset_id_quote
                }
                self.progressHUD.removeFromSuperview()
                
            }
        } catch {
            print(error)
            
        }
    }
}

