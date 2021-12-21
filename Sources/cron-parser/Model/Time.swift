struct Time: Equatable {
    var hour: Int
    var minute: Int
}

extension Time: Comparable {
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour < rhs.hour {
            return true
        } else if lhs.hour == rhs.hour {
            return lhs.minute < rhs.minute
        }
        return false
    }
}
