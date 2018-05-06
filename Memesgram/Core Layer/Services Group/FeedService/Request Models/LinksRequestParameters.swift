import Foundation

struct LinksRequestParameters: Codable, JSONSerializable {
    let after: String
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
        
        return dict
    }
}
