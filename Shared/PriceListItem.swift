//
//  PriceListItem.swift
//  Amberlerts (iOS)
//
//  Created by Joshua McKinnon on 12/12/21.
//

import SwiftUI

struct PriceListItem: View {
	var price: Price
	
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
		.frame(
			  minWidth: 0,
			  maxWidth: .infinity,
			  minHeight: 0,
			  maxHeight: .infinity,
			  alignment: .topLeading
			)
		.padding()
		.background(price.priceColorIndicator())
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

//struct PriceListItem_Previews: PreviewProvider {
//    static var previews: some View {
//		PriceListItem(price: )
//    }
//}
