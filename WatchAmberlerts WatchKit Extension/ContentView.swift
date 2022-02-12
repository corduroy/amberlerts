//
//  ContentView.swift
//  WatchAmberlerts WatchKit Extension
//
//  Created by Joshua McKinnon on 26/1/2022.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var network: Network
	@Environment(\.colorScheme) var currentMode
	@Environment(\.scenePhase) var scenePhase

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
		.onChange(of: scenePhase) { phase in
			if phase == .active {
				if (network.needsRefresh()) {
					network.fetchData()
				}
			}
		}
		.task {
			network.fetchData()
		}
		.refreshable {
			network.fetchData()
		}
	}
	
	
}

//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//		ContentView(network: Network)
//	}
//	
//}
