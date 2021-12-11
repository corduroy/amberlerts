//
//  ContentView.swift
//  Shared
//
//  Created by Joshua McKinnon on 3/12/21.
//

import SwiftUI


struct ContentView: View {
	@EnvironmentObject var network: Network
	let currencyFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		return formatter
	}()
	let percentFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .percent
		return formatter
	}()
	
	let lowPriceColor = Color.green
	let midPriceColor = Color.orange
	let highPriceColor = Color.red
	let amberColor = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))
	
	var body: some View {
		NavigationView {
			
			ZStack {
				Color.white
					.ignoresSafeArea()
				ScrollView{
					VStack(alignment: .leading) {
						let generalPrices = network.prices.filter{$0.channelType == "general"}
						ForEach(generalPrices) { price in
							HStack(alignment:.top) {
								Text(price.startTime, style: .time)
									.foregroundColor(textColorForDate(date: price.startTime))
									.bold()
								VStack(alignment: .leading) {
									Text(currencyFormatter.string(for: price.perKwh)!)
										.bold()
										.foregroundColor(textColorForDate(date: price.startTime))
									Text("Renewables: ")
										.foregroundColor(textColorForDate(date: price.startTime))
									+ Text(percentFormatter.string(from: NSNumber(value: price.renewables/100))!)
										.foregroundColor(textColorForDate(date: price.startTime))
								}
							}
						}
						.frame(width: 300, alignment: .leading)
						.padding()
						.background(amberColor)
						.cornerRadius(20)
					}
				}
				.onAppear {
				}
				.frame(alignment: .center)
			}
			.navigationTitle("Current Prices")
			.foregroundColor(Color.black)
			.background(Color.white)
			
		}
		.task {
			do {
				network.sites = try await network.getSites()
			} catch {
				print("Error", error)
			}
			do {
				network.prices = try await network.getPrices()
			} catch {
				print("Error", error)
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

func textColorForDate(date: Date) -> Color {
	var textColor = Color.black
	if date < Date() {
		textColor = Color.gray
	}
	return textColor
}
