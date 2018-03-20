import Vapor
import HTTP

// MARK: - Initialization

let drop = Droplet()
let allBeers = try? loadBeers(drop.workDir + "Resources/beer.json")


// MARK: - Routing

// /
drop.get { request in
    return "Hello World"
}

// /beers?start=0&limit=10
drop.get("beers") { request in

    guard let allBeers = allBeers else {
        return Response(status: .internalServerError)
    }

    let suportedTypes: [ResponseType] = [.json, .octetStream]

    guard let mediaType = request.accept.first?.mediaType,
        let requestedType = ResponseType(rawValue: mediaType) else {
            throw Abort.custom(status: .badRequest, message: "Unsuported accept type: \(request.accept.first?.mediaType).")
    }

    var start: Int = request.data["start"]?.int ?? 0
    var limit: Int = request.data["limit"]?.int ?? 10

    start = start < allBeers.count ? start : -1
    limit = (start + limit) < allBeers.count ? limit : allBeers.count - 1 - start

    guard start != -1, limit != -1 else {
        throw Abort.custom(status: .badRequest, message: "Invalid start or/and limit parameters.")
    }

    let slice: ArraySlice<Beer> = allBeers[start..<(start + limit)]
    var beerList = BeerList()
    beerList.beers = Array(slice)

    do {
        switch requestedType {
        case .json:
            return try beerList.toJSON()
        case .octetStream:
            return try beerList.toProto()
        }
    } catch {
        return Response(status: .internalServerError)
    }
}

// MARK: - Startup Point

drop.run()
