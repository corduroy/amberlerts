//
//  Prices.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import Foundation

struct Price:  Identifiable,Decodable {
    let id = UUID()
//    var id:             Int
    var type:           String
    var date:           String
    var duration:       Int
    var startTime:      Date
    var endTime:        Date
    var perKwh:         Double
    var channelType:    String
    var renewables:     Double
}
