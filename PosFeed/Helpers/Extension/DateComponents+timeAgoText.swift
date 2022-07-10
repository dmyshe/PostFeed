//
//  DateComponents.swift
//  PostFeed
//
//  Created by Дмитро  on 09.07.2022.
//

import Foundation


extension DateComponents {
    private enum TimeAgoType: String {
        case year,month,day,hour,minute,second
    }
    
    public var timeAgoText: String {
        convertTimeAgoToText()
    }
    
    private func convertTimeAgoToText() -> String {
        switch self {
        case (let time) where time.year! >= 1:
            return createTimeAgoText(for: .year, withValue: time.year!)
        case (let time) where time.month! < 12:
            return createTimeAgoText(for: .month, withValue: time.month!)
        case (let time) where time.day! < 30:
            return createTimeAgoText(for: .day, withValue: time.day!)
        case (let time) where time.hour! < 24:
            return createTimeAgoText(for: .hour, withValue: time.hour!)
        case (let time) where time.minute! < 60:
            return createTimeAgoText(for: .minute, withValue: time.minute!)
        case (let time) where time.second! < 60:
            return createTimeAgoText(for: .second, withValue: time.second!)
        default:
            print(" no calculate in method calculateWhenPostWasSent")
        }
        return " "
    }
    
    
    private func createTimeAgoText(for time: TimeAgoType, withValue value: Int) -> String {
        let timeName = time.rawValue
        let time = value == 1 ? timeName : "\(timeName)s"
        let timeAgoText = "\(value) \(time) ago"
        return timeAgoText
    }
}
