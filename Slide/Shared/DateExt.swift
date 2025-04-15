import Foundation

extension Date {
    var timeAgoText: String {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: currentDate)
        
        return if let years = components.year, years > 0 {
            "\(years)년 전"
        } else if let months = components.month, months > 0 {
            "\(months)개월 전"
        } else if let days = components.day, days > 0 {
            "\(days)일 전"
        } else if let hours = components.hour, hours > 0 {
            "\(hours)시간 전"
        } else if let minutes = components.minute, minutes > 0 {
            "\(minutes)분 전"
        } else {
            "방금 전"
        }
    }
    
    subscript(component: Calendar.Component) -> Int {
        get {
            let calendar = Calendar.current
            return calendar.component(component, from: self)
        }
        set {
            let calendar = Calendar.current
            if let newDate = calendar.date(byAdding: component, value: newValue, to: self) {
                self = newDate
            }
        }
    }
}
