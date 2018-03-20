/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: DataModel.proto
 *
 */

import Foundation
import SwiftProtobuf


struct Beer: SwiftProtobuf.Message, SwiftProtobuf.Proto3Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf.ProtoNameProviding {
  public var swiftClassName: String {return "Beer"}
  public var protoMessageName: String {return "Beer"}
  public var protoPackageName: String {return ""}
  public static let _protobuf_fieldNames: FieldNameMap = [
    1: .same(proto: "alcohol", swift: "alcohol"),
    2: .same(proto: "name", swift: "name"),
    3: .same(proto: "brewedBy", swift: "brewedBy"),
    4: .same(proto: "style", swift: "style"),
    5: .same(proto: "availability", swift: "availability"),
    6: .same(proto: "serving", swift: "serving"),
    7: .same(proto: "details", swift: "details"),
  ]


  var alcohol: Double = 0

  var name: String = ""

  var brewedBy: String = ""

  var style: String = ""

  var availability: String = ""

  var serving: String = ""

  var details: String = ""

  init() {}

  public mutating func _protoc_generated_decodeField(setter: inout SwiftProtobuf.FieldDecoder, protoFieldNumber: Int) throws {
    switch protoFieldNumber {
    case 1: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufDouble.self, value: &alcohol)
    case 2: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &name)
    case 3: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &brewedBy)
    case 4: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &style)
    case 5: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &availability)
    case 6: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &serving)
    case 7: try setter.decodeSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: &details)
    default: break
    }
  }

  public func _protoc_generated_traverse(visitor: inout SwiftProtobuf.Visitor) throws {
    if alcohol != 0 {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufDouble.self, value: alcohol, protoFieldNumber: 1)
    }
    if name != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: name, protoFieldNumber: 2)
    }
    if brewedBy != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: brewedBy, protoFieldNumber: 3)
    }
    if style != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: style, protoFieldNumber: 4)
    }
    if availability != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: availability, protoFieldNumber: 5)
    }
    if serving != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: serving, protoFieldNumber: 6)
    }
    if details != "" {
      try visitor.visitSingularField(fieldType: SwiftProtobuf.ProtobufString.self, value: details, protoFieldNumber: 7)
    }
  }

  public func _protoc_generated_isEqualTo(other: Beer) -> Bool {
    if alcohol != other.alcohol {return false}
    if name != other.name {return false}
    if brewedBy != other.brewedBy {return false}
    if style != other.style {return false}
    if availability != other.availability {return false}
    if serving != other.serving {return false}
    if details != other.details {return false}
    return true
  }
}

struct BeerList: SwiftProtobuf.Message, SwiftProtobuf.Proto3Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf.ProtoNameProviding {
  public var swiftClassName: String {return "BeerList"}
  public var protoMessageName: String {return "BeerList"}
  public var protoPackageName: String {return ""}
  public static let _protobuf_fieldNames: FieldNameMap = [
    1: .same(proto: "beers", swift: "beers"),
  ]


  var beers: [Beer] = []

  init() {}

  public mutating func _protoc_generated_decodeField(setter: inout SwiftProtobuf.FieldDecoder, protoFieldNumber: Int) throws {
    switch protoFieldNumber {
    case 1: try setter.decodeRepeatedMessageField(fieldType: Beer.self, value: &beers)
    default: break
    }
  }

  public func _protoc_generated_traverse(visitor: inout SwiftProtobuf.Visitor) throws {
    if !beers.isEmpty {
      try visitor.visitRepeatedMessageField(value: beers, protoFieldNumber: 1)
    }
  }

  public func _protoc_generated_isEqualTo(other: BeerList) -> Bool {
    if beers != other.beers {return false}
    return true
  }
}
