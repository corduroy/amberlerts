//
//  Prices.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import Foundation
import SwiftUI
/**
 Represents the price of electricity for a time interval.
 
 - Note: See the [Amber API](https://app.amber.com.au/developers/) for more details
 */
struct Price:  Identifiable,Decodable {
    let id = UUID()
    var type:           String
    var date:           String
    var duration:       Int
    var startTime:      Date
    var endTime:        Date
    var perKwh:         Double
    var channelType:    String
    var renewables:     Double
	var spotPerKwh:		Double
	var spikeStatus:	String
	
	enum CodingKeys: String, CodingKey {
		case type
		case date
		case duration
		case startTime
		case endTime
		case perKwh
		case channelType
		case renewables
		case spotPerKwh
		case spikeStatus
	}
	/**
	 Provide an appropriate indicator color for this price
	 
	 The color indicator is intended to convey, visually, whether this price is Low, Moderate, or High.
	 
	 - Returns: The appropriate color indicator for this price
	 */
	func priceColorIndicator() -> Color {
		switch self.perKwh {
		case -100..<19.5:
			return Color(red: 0/255, green: 180/255, blue: 0/255)
		case 19.5..<23:
			return Color(red: 255/255, green: 165/255, blue: 0/255)
		case 23..<10000:
			return Color(red: 245/255, green: 0/255, blue: 0/255)
		default:
			return Color(red: 245/255, green: 0/255, blue: 0/255)
		}
	}
	
	/** Provide a nicely-formatted string value for the price
	 
	 Prices less than a dollar shown in cents, higher prices in dollars and cents.
	 
	 - Returns: A string that's appropriately formatted in either dollars or cents, depending on the magnitude of the price
	 */
	func priceString() -> String {
		let formatter = NumberFormatter()
		var multiplier: Double = 1
		if self.perKwh < 100 {
			multiplier = 1
			formatter.numberStyle = .decimal
			formatter.maximumFractionDigits = 0
			formatter.positiveSuffix = "c"
			formatter.negativeSuffix = formatter.positiveSuffix
		}else{
			multiplier = 1/100
			formatter.numberStyle = .currency
		}
		return formatter.string(for: (multiplier*self.perKwh)) ?? "no price"
	}
	
	func isCurrent() -> Bool {
		if startTime < Date() && endTime > Date() {
			return true
		}
		return false
	}
	
	func isPast() -> Bool {
		if endTime < Date() {
			return true
		}
		return false
	}
	
	func isFuture() -> Bool {
		if startTime > Date() {
			return true
		}
		return false
	}
}
/**
 Represents a Site, where the user consumes power. Corresponds to a single metered property.
 
 - Note: See the [Amber API](https://app.amber.com.au/developers/) for more details
 */
struct Site: Identifiable,Decodable {
    var id:     String
    var nmi:    String
	var channels:	[Channel]
}

struct Channel:	Identifiable,Decodable {
	var id:		String
	var type:	String
	
	enum CodingKeys: String, CodingKey {
		case id = "identifier"
		case type
	}
}
/**
 Represents historical usage for a single time interval.
 
 This is not yet exposed in the app (or collected)
 */
struct Usage: Identifiable,Decodable {
	var id =	UUID()
	var type:	String
	var duration:	Int
	var endTime:	Date
	var startTime:	Date
	var quality:	String
	var kwh:		Double
	var nemTime:	Date
	var perKwh:		Double
	var channelType:	String
	var channelIdentifier:	String
	var cost:		Double
	var renewables:	Double
	var spotPerKwh:	Double
	var spikeStatus:	String
	
	
	enum CodingKeys: String, CodingKey {
		case type
		case duration
		case endTime
		case quality
		case kwh
		case nemTime
		case perKwh
		case channelType
		case channelIdentifier
		case cost
		case renewables
		case spotPerKwh
		case startTime
		case spikeStatus
	}
}
