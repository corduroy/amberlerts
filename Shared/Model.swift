//
//  Prices.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import Foundation
import SwiftUI

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
	// Provide a nicely-formatted string value for the price
	func priceString() -> String {
		let formatter = NumberFormatter()
		var multiplier: Double = 1
		if self.perKwh < 100 {
			multiplier = 1
			formatter.numberStyle = .decimal
			formatter.maximumFractionDigits = 0
			formatter.positiveSuffix = "c"
			formatter.negativeSuffix = "c"
		}else{
			multiplier = 1/100
			formatter.numberStyle = .currency
		}
		return formatter.string(for: (multiplier*self.perKwh)) ?? "no price"
	}
}

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
