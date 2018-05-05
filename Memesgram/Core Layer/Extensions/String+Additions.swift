import Foundation

extension String {
  
    func stringByAdding(urlEncodedFields fields: JSON?) throws -> String {
        guard let f = fields else { return self }
        return try f.urlEncodedString(base: self)
    }
}
