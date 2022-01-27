//
//  PriceDetailView.swift
//  WatchAmberlerts WatchKit Extension
//
//  Created by Joshua McKinnon on 26/1/2022.
//

import SwiftUI

struct PriceDetailView: View {
	@Environment(\.colorScheme) var currentMode
	
	var price: Price
	let amberColor = Color(#colorLiteral(red: 0.1578277647, green: 0.1932222545, blue: 0.2605077624, alpha: 1))
	let percentFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .percent
		return formatter
	}()
	
	var body: some View {
		//		let renewablesValue = percentFormatter.string(from: NSNumber(value: price.renewables/100))!
		
		HStack(alignment:.center) {
			Rectangle()
				.fill(price.priceColorIndicator())
				.frame(width: 5)
				.padding(0)
			Text(price.startTime, style: .time)
				.foregroundColor(textColorForDate(date: price.startTime, mode:currentMode))
				.bold()
				.font(.system(size: 18))
			Spacer()
			Text(price.priceString())
				.bold()
				.foregroundColor(textColorForDate(date: price.startTime, mode:currentMode))
				.font(.system(size: 36))
		}
	}
}

func textColorForDate(date: Date, mode:ColorScheme) -> Color {
	var textColor = Color.white
	if date < Date() {
		// a less-prominent color for prices in the past
		if mode == .dark {
			textColor = Color(red: 0.7, green: 0.7, blue: 0.7)
		}else{
			textColor = Color(red: 0.9, green: 0.9, blue: 0.9)
		}
	}else{
		// a brighter color for uture Prices
		if mode == .dark {
			textColor = Color(red: 0.1, green: 0.7, blue: 0.7)
		}else{
			textColor = Color(red: 0.1, green: 0.8, blue: 0.8)
		}
	}
	return textColor
}

func opacityForDate(date: Date, mode:ColorScheme) -> Double {
	var opacity = 1.0
	if date < Date() {
		if mode == .dark {
			opacity = Double(0.65)
		}else{
			opacity = Double(0.8)
		}
	}
	return opacity
}


//struct PriceDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PriceDetailView()
//    }
//}
