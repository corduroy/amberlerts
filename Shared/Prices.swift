//
//  Prices.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import Foundation

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