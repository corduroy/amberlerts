//
//  ComplicationController.swift
//  WatchAmberlerts WatchKit Extension
//
//  Created by Joshua McKinnon on 26/1/2022.
//

import ClockKit
import SwiftUI
import os
class ComplicationController: NSObject, CLKComplicationDataSource {
//	@ObservedObject var network: Network

	let logger = Logger(subsystem: "biz.corduroy.amberlerts.watchkitapp",
						category: "Complication")

	// MARK: - Complication Configuration
	
	func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
		let descriptors = [
//			CLKComplicationDescriptor(identifier: "complication", displayName: "Amberlerts", supportedFamilies: CLKComplicationFamily.allCases),
			CLKComplicationDescriptor(identifier: "curentPrice", displayName: "Current Power Price", supportedFamilies: [CLKComplicationFamily.circularSmall,CLKComplicationFamily.utilitarianSmall])
			// Multiple complication support can be added here with more descriptors
		]
		
		// Call the handler with the currently supported complication descriptors
		handler(descriptors)
	}
	
	func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
		// Do any necessary work to support these newly shared complication descriptors
	}
	
	// MARK: - Timeline Configuration
	
	
	func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
		// Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
		
		// Indicate that the app can provide timeline entries for the next 24 hours.
		let endDate = Date().addingTimeInterval(24.0 * 60.0 * 60.0)
		
		handler(endDate)
	}
	
	func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
		// Call the handler with your desired behavior when the device is locked
		handler(.showOnLockScreen)
	}
	
	// MARK: - Timeline Population
	
	func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
		// Call the handler with the current timeline entry
		handler(createTimelineEntry(forComplication: complication, date: Date()))
	}
	
	func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
		// Call the handler with the timeline entries after the given date
		handler(nil)
	}
	
	// MARK: - Sample Templates
	
	func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
		// This method will be called once per supported complication, and the results will be cached
		let future = Date().addingTimeInterval(25.0 * 60.0 * 60.0)
		handler(createTemplate(forComplication: complication, date: future))
	}
	
	// MARK: - Creating Templates
	
	// Select the correct template based on the complication's family.
	private func createTemplate(forComplication complication: CLKComplication, date: Date) -> CLKComplicationTemplate {
		switch complication.family {
//		case .modularSmall:
//			return createModularSmallTemplate(forDate: date)
//		case .modularLarge:
//			return createModularLargeTemplate(forDate: date)
//		case .utilitarianSmall, .utilitarianSmallFlat:
//			return createUtilitarianSmallFlatTemplate(forDate: date)
//		case .utilitarianLarge:
//			return createUtilitarianLargeTemplate(forDate: date)
//		case .circularSmall:
//			return createCircularSmallTemplate(forDate: date)
//		case .extraLarge:
//			return createExtraLargeTemplate(forDate: date)
//		case .graphicCorner:
//			return createGraphicCornerTemplate(forDate: date)
//		case .graphicCircular:
//			return createGraphicCircleTemplate(forDate: date)
//		case .graphicRectangular:
//			return createGraphicRectangularTemplate(forDate: date)
//		case .graphicBezel:
//			return createGraphicBezelTemplate(forDate: date)
//		case .graphicExtraLarge:
//			return createGraphicExtraLargeTemplate(forDate: date)
		@unknown default:
			logger.error("Unknown Complication Family")
			fatalError()
		}
	}
	
	// Return a circular small template.
//	private func createCircularSmallTemplate(forDate date: Date) -> CLKComplicationTemplate {
//		// Create the data providers.
//		let currentPrice = network.prices.first
//		let priceProvider = CLKSimpleTextProvider(text: "22.5" )//currentPrice?.priceString() ?? "0.0")
//		let unitProvider = CLKSimpleTextProvider(text: "c/kWh", shortText: "c")
//		let fillFraction = Float(0.5)
//		let ringStyle = CLKComplicationRingStyle.open
//		// Create the template using the providers.
//		return CLKComplicationTemplateCircularSmallStackText(line1TextProvider: priceProvider,
//															 line2TextProvider: unitProvider)
//	}

	private func createTimelineEntry(forComplication complication: CLKComplication, date: Date) -> CLKComplicationTimelineEntry {
		
		// Get the correct template based on the complication.
		let template = createTemplate(forComplication: complication, date: date)
		
		// Use the template and date to create a timeline entry.
		return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
	}
}
