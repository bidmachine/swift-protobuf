// Sources/SwiftProtobuf/Google_Protobuf_Wrappers+Extensions.swift - Well-known wrapper type extensions
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Extensions to the well-known types in wrapper.proto that customize the JSON
/// format of those messages and provide convenience initializers from literals.
///
// -----------------------------------------------------------------------------

import Foundation

/// Internal protocol that minimizes the code duplication across the multiple
/// wrapper types extended below.
protocol ProtobufWrapper {

  /// The wrapped protobuf type (for example, `ProtobufDouble`).
  associatedtype WrappedType: FieldType

  /// Exposes the generated property to the extensions here.
  var value: WrappedType.BaseType { get set }

  /// Exposes the parameterless initializer to the extensions here.
  init()

  /// Creates a new instance of the wrapper with the given value.
  init(_ value: WrappedType.BaseType)
}

extension ProtobufWrapper {
  mutating func decodeJSON(from decoder: inout JSONDecoder) throws {
    var v: WrappedType.BaseType?
    try WrappedType.decodeSingular(value: &v, from: &decoder)
    value = v ?? WrappedType.proto3DefaultValue
  }
}

extension Google_Protobuf_DoubleValue:
  ProtobufWrapper, ExpressibleByFloatLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufDouble
  internal typealias FloatLiteralType = WrappedType.BaseType

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(floatLiteral: FloatLiteralType) {
    self.init(floatLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    if value.isFinite {
      // Swift 4.2 and later guarantees that this is accurate
      // enough to parse back to the exact value on the other end.
      return value.description
    } else {
      // Protobuf-specific handling of NaN and infinities
      var encoder = JSONEncoder()
      encoder.putDoubleValue(value: value)
      return encoder.stringResult
    }
  }
}

extension Google_Protobuf_FloatValue:
  ProtobufWrapper, ExpressibleByFloatLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufFloat
  internal typealias FloatLiteralType = Float

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(floatLiteral: FloatLiteralType) {
    self.init(floatLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    if value.isFinite {
      // Swift 4.2 and later guarantees that this is accurate
      // enough to parse back to the exact value on the other end.
      return value.description
    } else {
      // Protobuf-specific handling of NaN and infinities
      var encoder = JSONEncoder()
      encoder.putFloatValue(value: value)
      return encoder.stringResult
    }
  }
}

extension Google_Protobuf_Int64Value:
  ProtobufWrapper, ExpressibleByIntegerLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufInt64
  internal typealias IntegerLiteralType = WrappedType.BaseType

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(integerLiteral: IntegerLiteralType) {
    self.init(integerLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    return "\"" + String(value) + "\""
  }
}

extension Google_Protobuf_UInt64Value:
  ProtobufWrapper, ExpressibleByIntegerLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufUInt64
  internal typealias IntegerLiteralType = WrappedType.BaseType

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(integerLiteral: IntegerLiteralType) {
    self.init(integerLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    return "\"" + String(value) + "\""
  }
}

extension Google_Protobuf_Int32Value:
  ProtobufWrapper, ExpressibleByIntegerLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufInt32
  internal typealias IntegerLiteralType = WrappedType.BaseType

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(integerLiteral: IntegerLiteralType) {
    self.init(integerLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    return String(value)
  }
}

extension Google_Protobuf_UInt32Value:
  ProtobufWrapper, ExpressibleByIntegerLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufUInt32
  internal typealias IntegerLiteralType = WrappedType.BaseType

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(integerLiteral: IntegerLiteralType) {
    self.init(integerLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    return String(value)
  }
}

extension Google_Protobuf_BoolValue:
  ProtobufWrapper, ExpressibleByBooleanLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufBool
  internal typealias BooleanLiteralType = Bool

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(booleanLiteral: Bool) {
    self.init(booleanLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    return value ? "true" : "false"
  }
}

extension Google_Protobuf_StringValue:
  ProtobufWrapper, ExpressibleByStringLiteral, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufString
  internal typealias StringLiteralType = String
  internal typealias ExtendedGraphemeClusterLiteralType = String
  internal typealias UnicodeScalarLiteralType = String

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  internal init(stringLiteral: String) {
    self.init(stringLiteral)
  }

  internal init(extendedGraphemeClusterLiteral: String) {
    self.init(extendedGraphemeClusterLiteral)
  }

  internal init(unicodeScalarLiteral: String) {
    self.init(unicodeScalarLiteral)
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    var encoder = JSONEncoder()
    encoder.putStringValue(value: value)
    return encoder.stringResult
  }
}

extension Google_Protobuf_BytesValue: ProtobufWrapper, _CustomJSONCodable {

  internal typealias WrappedType = ProtobufBytes

  internal init(_ value: WrappedType.BaseType) {
    self.init()
    self.value = value
  }

  func encodedJSONString(options: JSONEncodingOptions) throws -> String {
    var encoder = JSONEncoder()
    encoder.putBytesValue(value: value)
    return encoder.stringResult
  }
}
