import Foundation

struct FeedPaginator {
    enum TimePeriod: String {
        case hour, day, week, month, year, all
    }
    
    var limit = 50
    var after = ""
    var requestPeriod = TimePeriod.week
    
    var toRequestParams: LinksRequestParameters {
        return LinksRequestParameters(after: after,
                                      limit: 50,
                                      requestPeriod: requestPeriod.rawValue)
    }
    
}
