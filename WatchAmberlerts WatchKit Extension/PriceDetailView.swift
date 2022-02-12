//
//  PriceDetailView.swift
//  WatchAmberlerts WatchKit Extension
//
//  Created by Joshua McKinnon on 26/1/2022.
//
import SwiftUI
import ClockKit

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
			// Color-code column
				.fill(price.priceColorIndicator())
				.frame(width: 5)
				.padding(0)
			// Time Column
			Text(price.startTime, style: .time)
				.foregroundColor(textColorForDate(date: price.endTime, mode:currentMode))
				.bold()
				.font(.system(size: 16))
			Spacer()
			// The Price
			Text(price.priceString())
				.bold()
				.foregroundColor(textColorForDate(date: price.endTime, mode:currentMode))
				.font(.system(size: 34))
		}
		.padding()
		.opacity(opacityForDate(date: price.endTime, mode:currentMode))
		// Border to highlight the current price
		.overlay(
			RoundedRectangle(cornerRadius: 5)
				.stroke(price.priceColorIndicator(), lineWidth: borderWidthForPrice(price: price))
				.padding(.horizontal,-8)
		)

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

func borderWidthForPrice(price: Price) -> Double {
	if price.startTime < Date() && price.endTime > Date() {
		return 4.0
	} else {
		return 0.0
	}
}




struct GaugeComplicationView: View {
  @State var acidity = 5.9

  var body: some View {
	Gauge(value: acidity, in: 15...30) {
	  Image(systemName: "drop.fill")
		.foregroundColor(.green)
	} currentValueLabel: {
	  Text("\(acidity, specifier: "%.1f")")
	} minimumValueLabel: {
	  Text("15")
	} maximumValueLabel: {
	  Text("30")
	}
	.gaugeStyle(CircularGaugeStyle())
  }
}

struct PriceDetailView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
		PriceDetailView(price: Price(type: "ForecastInterval", date: "2021-12-17", duration: 30, startTime: Date(), endTime: Date().addingTimeInterval(60*30), perKwh: 21, channelType: "General", renewables: 12.2, spotPerKwh: 8.8, spikeStatus: "none"))
			
			GaugeComplicationView()
		}
}
}
//struct GaugeSample_Previews: PreviewProvider {
//	static var previews: some View {
//		CLKComplicationTemplateGraphicCornerGaugeText
//		(GaugeComplicationView())
//			.previewContext()
//	}
//}
