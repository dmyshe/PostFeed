//
//  Date.swift
//  PostFeed
//
//  Created by Дмитро  on 09.07.2022.
//

import Foundation


extension Date {
    /// Calculate difference between current date and specified date.
    public func calculateDiffBetweenCurrentDate(and date: Date, in dateComponents: Set<Calendar.Component>) -> DateComponents {
        calculateDiffBetween(date, to: Date(), in: dateComponents)
    }
    /// Calculate difference between one date and another.
    public func calculateDiffBetween(_ date: Date, to toDate: Date ,in dateComponents: Set<Calendar.Component>) -> DateComponents {
        return  Calendar.current.dateComponents(dateComponents, from: date, to: toDate)
    }
}
