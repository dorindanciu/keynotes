import Foundation

protocol DictionaryInitializable {
    init(dictionary: [String: Any]) throws
}

extension Beer: DictionaryInitializable {
    init(dictionary: [String: Any]) throws {
        guard let name = dictionary["name"] as? String,
            let brewedBy = dictionary["brewedBy"] as? String,
        let style = dictionary["style"] as? String,
        let availability = dictionary["availability"] as? String,
        let serving = dictionary["serving"] as? String,
        let alcohol = dictionary["alcohol"] as? Double,
        let details = dictionary["details"] as? String else {
            throw "Invalid dictionary"
        }

        self.init()
        self.alcohol = alcohol
        self.name = name
        self.brewedBy = brewedBy
        self.style = style
        self.availability = availability
        self.serving = serving
        self.details = details
    }
}
