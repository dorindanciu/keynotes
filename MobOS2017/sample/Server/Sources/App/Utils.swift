import Foundation

func loadBeers(_ path: String) throws -> [Beer] {
    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: Any]]

    var beers = try jsonResult.map({ try Beer(dictionary:  $0)}) // 22
    beers.append(contentsOf: beers) // 44
    beers.append(contentsOf: beers) // 88
    beers.append(contentsOf: beers) // 176

    return beers
}
