import Foundation

struct LinksRequestParameters: Codable, JSONSerializable {
    enum TimePeriod: String {
        case hour, day, week, month, year, all
    }
    
    let after: String
    let before: String
    let limit: Int
    let requestPeriod: String
    
    var jsonDict: JSON {
        var dict = [
                    "limit": "\(limit)",
                    "t": requestPeriod
                    ]
        
        if after.count > 0 {
            dict["after"] = after
        }
        if before.count > 0 {
            dict["before"] = before
        }
        
        return dict
    }
}
