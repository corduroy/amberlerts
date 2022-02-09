//
//  ContentView.swift
//  WatchAmberlerts WatchKit Extension
//
//  Created by Joshua McKinnon on 26/1/2022.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var network: Network
	@Environment(\.colorScheme) var currentMode
	
	var body: some View {
		NavigationView {
			List {
				let generalPrices = network.prices.filter{$0.channelType == "general"}
				ForEach(generalPrices) { price in
					PriceDetailView(price: price)
				}
			}
//			.padding()
			.navigationTitle("⚡️ Prices")
			.listStyle(.plain)
		}
		.task {
			do {
				network.sites = try await network.getSites()
			} catch {
				print("Error Getting Sites", error)
			}
			do {
				network.prices = try await network.getPrices()
			} catch {
				print("Error Getting Prices", error)
			}
		}
	}
	
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
	
}
