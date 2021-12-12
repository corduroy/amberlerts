//
//  PriceListItem.swift
//  Amberlerts (iOS)
//
//  Created by Joshua McKinnon on 12/12/21.
//

import SwiftUI

struct PriceListItem: View {
	var price: Price
	let amberColor = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))

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
	
    var body: some View {
		HStack(alignment:.center) {
			Rectangle()
				.fill(price.priceColorIndicator())
				.frame(width: 5)
				.padding(0)
			Text(price.startTime, style: .time)
				.foregroundColor(textColorForDate(date: price.startTime))
				.bold()
				.padding(.trailing,20.0)
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
		.frame(
			  minWidth: 0,
			  maxWidth: .infinity,
			  minHeight: 0,
			  maxHeight: .infinity,
			  alignment: .topLeading
			)
		.padding()
		.background(amberColor)
		.opacity(opacityForDate(date: price.startTime))
		.cornerRadius(10)
    }
}

func textColorForDate(date: Date) -> Color {
	var textColor = Color.black
	if date < Date() {
		textColor = Color.gray
	}
	return textColor
}

func opacityForDate(date: Date) -> Double {
	var opacity = 1.0
	if date < Date() {
		opacity = Double(0.5)
	}
	return opacity
}

struct PriceListItem_Previews: PreviewProvider {
    static var previews: some View {
		PriceListItem(price: Price(type: "None",
								   date:  "2022-12-04",
								   duration: 30,
								   startTime: Date(timeIntervalSinceNow: 4800),
								   endTime: Date(timeIntervalSinceNow: 6600),
								   perKwh: 22.0,
								   channelType: "general",
								   renewables: 78.9,
								   spotPerKwh: 7.5,
								   spikeStatus: "none"))
    }
}
