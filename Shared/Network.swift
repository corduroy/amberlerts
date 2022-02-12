//
//  Network.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import SwiftUI
import os

class Network: ObservableObject {
	let logger = Logger(subsystem:
							"biz.corduroy.amberlerts",
						category: "Networking")
	
    @Published var prices: [Price] = []
	@Published var sites: [Site] = []

	var lastRefreshed: Date = Date(timeIntervalSince1970: 0.0)
	let apiKey = Bundle.main.infoDictionary!["APIKey"] as! String
	let baseURL = "https://api.amber.com.au/v1/"
    
	func pricesUrl() -> URL {
		let urlString = self.baseURL + "sites/" + self.sites[0].id + "/prices/current?next=28&previous=1"
		return URL(string: urlString)!
	}
	
	func sitesUrl() -> URL {
		let urlString = self.baseURL + "sites"
		return URL(string: urlString)!
	}
	
	func getPrices() async throws {
		var urlRequest = URLRequest(url: self.pricesUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		let httpResponse = response as! HTTPURLResponse //What is the case where this would not be of type HTTPURLResponse?
		if (httpResponse.statusCode != 200) {
			//TODO: Error Handling!
			logger.critical("\(httpResponse.statusCode) code when requesting Prices")
			fatalError("Error while fetching data")
		}
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let decodedPrices = try decoder.decode([Price].self, from: data)
		DispatchQueue.main.sync {
			self.prices = decodedPrices
			self.lastRefreshed = Date()
		}
	}
	
	func getSites() async throws {
		var urlRequest = URLRequest(url: self.sitesUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		let httpResponse = response as! HTTPURLResponse
		if (httpResponse.statusCode != 200) {
			//TODO: Error Handling!
			logger.critical("\(httpResponse.statusCode) code when requesting Sites")
			fatalError("Error while fetching data")
		}
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let decodedSites = try decoder.decode([Site].self, from: data)
		DispatchQueue.main.sync {
			self.sites = decodedSites
		}
	}
	func refreshData() async {
		do {
			try await self.getSites()
		} catch {
			print("Error Getting Sites", error)
		}
		do {
			try await self.getPrices()
		} catch {
			print("Error Getting Prices", error)
		}
	}
	/**
	 Provide a hint as to whether the data stored really needs updating
	 
	 When auto-refreshing (for example, when returning from the background), we don't need to refresh
	 from the network if we've recently done that. Amber's prices are updated every 5 minutes,
	 so we'll choose an interval a bit shorter than that.
	 
	 - Returns `true` if we should get new data.
	 */
	func needsRefresh() -> Bool {
		return lastRefreshed.timeIntervalSinceNow < -60*2.5
	}
	
	func fetchData() {
		Task.init {
			do {
				try await self.getSites()
			} catch {
				print("Error Getting Sites", error)
			}
			do {
				try await self.getPrices()
			} catch {
				print("Error Getting Prices", error)
			}
		}
	}

}
