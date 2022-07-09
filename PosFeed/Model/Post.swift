//
//  Post.swift
//  PosFeed
//
//  Created by Дмитро  on 06.07.2022.
//

import Foundation

struct Posts: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}


extension Post {
    var likesText: String {
        "❤️\(likesCount)"
    }
    
    var timeAgoText: String {
        calculateWhenPostWasSent()
    }
    
    func calculateTimePost(in dateComponents: Set<Calendar.Component>) -> DateComponents {
        print(timeshamp)
        let date = Date(timeIntervalSince1970: Double(timeshamp))
        let currentDate = Date()
        let daysAgo = Calendar.current.dateComponents(dateComponents, from: date, to: currentDate)
        
        return daysAgo
    }
    
    private func calculateWhenPostWasSent() -> String {
        let time = calculateTimePost(in: [.second,.minute,.hour,.day,.month,.year])
        return  check(time)
    }

    private func check(_ time: DateComponents) -> String {
        switch time {
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
}
