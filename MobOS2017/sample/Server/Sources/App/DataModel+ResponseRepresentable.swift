import Foundation
import Vapor
import HTTP

extension Beer: NodeRepresentable {
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "name": name,
            "brewedBy": brewedBy,
            "style": style,
            "availability": availability,
            "serving": serving,
            "alcohol": alcohol,
            "details": details
            ])
    }
}


extension BeerList {
    func toJSON() throws -> ResponseRepresentable {
        guard let data = try? self.serializeJSON() else {
            return Response(status: .internalServerError)
        }
        return Response(status: .ok, headers: ["Content-Type": "application/json"], body: data)
    }

    func toProto() throws -> ResponseRepresentable {
        guard let data = try? self.serializeProtobuf() else {
            return Response(status: .internalServerError)
        }
        return Response(status: .ok, headers: ["Content-Type": "application/octet-stream"], body: data)
    }
}
