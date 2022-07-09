//
//  DateComponents.swift
//  PostFeed
//
//  Created by Дмитро  on 09.07.2022.
//

import Foundation


extension DateComponents {
    
     var timeAgoText: String {
        convertTimeAgoToText()
    }
    
    
    private func convertTimeAgoToText() -> String {
        switch self {
        case (let time) where time.year! >= 1:
            let year = time.year! == 1 ? "year" : "years"
            return "\(time.year!) \(year) ago"
        case (let time) where time.month! < 12:
            let month = time.month! == 1 ? "month" : "months"
            return "\(time.month!) \(month) ago"
        case (let time) where time.day! < 30:
            let day = time.day! == 1 ? "day" : "days"
            return "\(time.day!) \(day) ago"
        case (let time) where time.hour! < 24:
            let hour = time.hour! == 1 ? "hour" : "hours"
            return "\(time.hour!) \(hour) ago"
        case (let time) where time.minute! < 60:
            let minute = time.minute! == 1 ? "minute" : "minutes"
            return "\(time.minute!) \(minute) ago"
        case (let time) where time.second! < 60:
            let sec = time.minute! == 1 ? "second" : "seconds"
            return "\(time.second!) \(sec) ago"
            
        default:
            print(" no calculate in method calculateWhenPostWasSent")
        }
        return " "
    }

    
//    func example() {
//        let dateComponents = self.day.des
//    }
}
