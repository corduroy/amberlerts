//
//  ContentView.swift
//  Shared
//
//  Created by Joshua McKinnon on 3/12/21.
//

import SwiftUI
struct ContentView: View {
	@EnvironmentObject var network: Network
	
	let amberColor = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))
	var body: some View {
		NavigationView {
			ScrollView{
				LazyVStack() {
					let generalPrices = network.prices.filter{$0.channelType == "general"}
					ForEach(generalPrices) { price in
						PriceListItem(price: price)
					}
				}
			}
			.navigationTitle("Current Prices")
			.foregroundColor(Color.black)
			.background(Color.white)
			.padding()
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
            .environmentObject(Network())
    }
}


