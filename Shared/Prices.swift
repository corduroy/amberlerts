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
}

struct Site: Identifiable,Decodable {
    var id:     String
    var nmi:    Int64
	var channels:	[Channel]
}

struct Channel:	Identifiable,Decodable {
	let id = UUID()
	var identifier:	String
	var type:		String
}
