//
//  ContentView.swift
//  Shared
//
//  Created by Joshua McKinnon on 3/12/21.
//

import SwiftUI
struct ContentView: View {
	@EnvironmentObject var network: Network
	@Environment(\.colorScheme) var currentMode
	@Environment(\.scenePhase) var scenePhase

	let amberColor = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))
	var body: some View {
		NavigationView {
			List {
					let generalPrices = network.prices.filter{$0.channelType == "general"}
					ForEach(generalPrices) { price in
						PriceListItem(price: price)
					}
			}
			.navigationTitle("Amber ⚡️ Price")
			.listStyle(.plain)
			.listRowSeparator(.hidden)
		}
		// Update the data whenever the app comes to the foreground
		.onChange(of: scenePhase) { phase in
			if phase == .active {
//				refreshData()
			}
		}
		.refreshable {
//			await refreshData()
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
	func refreshData() async {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}


