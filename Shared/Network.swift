//
//  Network.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import SwiftUI

class Network: ObservableObject {
    @Published var prices: [Price] = []
	@Published var sites: [Site] = []
    
	let apiKey = Bundle.main.infoDictionary!["APIKey"] as! String
	let baseURL = "https://api.amber.com.au/v1/"
    
	func pricesUrl() -> URL {
		let urlString = self.baseURL + "sites/" + self.sites[0].id + "/prices/current?next=28&previous=2"
		return URL(string: urlString)!
	}
	
	func sitesUrl() -> URL {
		let urlString = self.baseURL + "sites"
		return URL(string: urlString)!
	}
	
	func getPrices() async throws -> [Price] {
		var urlRequest = URLRequest(url: self.pricesUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			fatalError("Error while fetching data")
			//TODO: Error Handling!
		}
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let decodedPrices = try decoder.decode([Price].self, from: data)
		return decodedPrices
	}
	
	func getSites() async throws -> [Site] {
		var urlRequest = URLRequest(url: self.sitesUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			fatalError("Error while fetching data")
			//TODO: Error Handling!
		}
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let decodedSites = try decoder.decode([Site].self, from: data)
		return decodedSites
	}
}
