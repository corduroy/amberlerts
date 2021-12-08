//
//  Network.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import SwiftUI

class Network: ObservableObject {
    @Published var prices: [Price] = []
    
    let baseURL = "https://api.amber.com.au/v1/sites/01FNTJ84M9BZJMSGK2WW633ZS0/prices/current?next=6"
    let headers = ["Authorization":"Bearer psk_0d3d429582b0055926e21621582c4e65"]
    
    func getPrices() {
        guard let url = URL(string: baseURL) else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer psk_0d3d429582b0055926e21621582c4e65", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        var decoder = JSONDecoder.init()
                        decoder.dateDecodingStrategy = .iso8601
                        let decodedPrices = try decoder.decode([Price].self, from: data)
                        
                        self.prices = decodedPrices
                        print("Prices:",self.prices)

                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
