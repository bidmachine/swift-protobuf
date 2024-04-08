// Sources/SwiftProtobuf/ExtensionFields.swift - Extension support
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Core protocols implemented by generated extensions.
///
// -----------------------------------------------------------------------------

#if !swift(>=4.2)
private let i_2166136261 = Int(bitPattern: 2166136261)
private let i_16777619 = Int(16777619)
#endif

// TODO: `AnyExtensionField` should require `Sendable` but we cannot do so yet without possibly breaking compatibility.

//
// Type-erased Extension field implementation.
// Note that it has no "self or associated type" references, so can
// be used as a protocol type.  (In particular, although it does have
// a hashValue property, it cannot be Hashable.)
//
// This can encode, decode, return a hashValue and test for
// equality with some other extension field; but it's type-sealed
// so you can't actually access the contained value itself.
//
internal protocol AnyExtensionField: CustomDebugStringConvertible {
#if swift(>=4.2)
  func hash(into hasher: inout Hasher)
#else
  var hashValue: Int { get }
#endif
  var protobufExtension: AnyMessageExtension { get }
  func isEqual(other: AnyExtensionField) -> Bool

  /// Merging field decoding
  mutating func decodeExtensionField<T: Decoder>(decoder: inout T) throws

  /// Fields know their own type, so can dispatch to a visitor
  func traverse<V: Visitor>(visitor: inout V) throws

  /// Check if the field is initialized.
  var isInitialized: Bool { get }
}

extension AnyExtensionField {
  // Default implementation for extensions fields.  The message types below provide
  // custom versions.
  internal var isInitialized: Bool { return true }
}

///
/// The regular ExtensionField type exposes the value directly.
///
internal protocol ExtensionField: AnyExtensionField, Hashable {
  associatedtype ValueType
  var value: ValueType { get set }
  init(protobufExtension: AnyMessageExtension, value: ValueType)
  init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws
}

///
/// Singular field
///
internal struct OptionalExtensionField<T: FieldType>: ExtensionField {
  internal typealias BaseType = T.BaseType
  internal typealias ValueType = BaseType
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: OptionalExtensionField,
                        rhs: OptionalExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

  internal var debugDescription: String {
    get {
      return String(reflecting: value)
    }
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get { return value.hashValue }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! OptionalExtensionField<T>
    return self == o
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
      var v: ValueType?
      try T.decodeSingular(value: &v, from: &decoder)
      if let v = v {
          value = v
      }
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType?
    try T.decodeSingular(value: &v, from: &decoder)
    if let v = v {
      self.init(protobufExtension: protobufExtension, value: v)
    } else {
      return nil
    }
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    try T.visitSingular(value: value, fieldNumber: protobufExtension.fieldNumber, with: &visitor)
  }
}

///
/// Repeated fields
///
internal struct RepeatedExtensionField<T: FieldType>: ExtensionField {
  internal typealias BaseType = T.BaseType
  internal typealias ValueType = [BaseType]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: RepeatedExtensionField,
                        rhs: RepeatedExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! RepeatedExtensionField<T>
    return self == o
  }

  internal var debugDescription: String {
    return "[" + value.map{String(reflecting: $0)}.joined(separator: ",") + "]"
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try T.decodeRepeated(value: &value, from: &decoder)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try T.decodeRepeated(value: &v, from: &decoder)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try T.visitRepeated(value: value, fieldNumber: protobufExtension.fieldNumber, with: &visitor)
    }
  }
}

///
/// Packed Repeated fields
///
/// TODO: This is almost (but not quite) identical to RepeatedFields;
/// find a way to collapse the implementations.
///
internal struct PackedExtensionField<T: FieldType>: ExtensionField {
  internal typealias BaseType = T.BaseType
  internal typealias ValueType = [BaseType]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: PackedExtensionField,
                        rhs: PackedExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! PackedExtensionField<T>
    return self == o
  }

  internal var debugDescription: String {
    return "[" + value.map{String(reflecting: $0)}.joined(separator: ",") + "]"
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try T.decodeRepeated(value: &value, from: &decoder)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try T.decodeRepeated(value: &v, from: &decoder)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try T.visitPacked(value: value, fieldNumber: protobufExtension.fieldNumber, with: &visitor)
    }
  }
}

///
/// Enum extensions
///
internal struct OptionalEnumExtensionField<E: Enum>: ExtensionField where E.RawValue == Int {
  internal typealias BaseType = E
  internal typealias ValueType = E
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: OptionalEnumExtensionField,
                        rhs: OptionalEnumExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

  internal var debugDescription: String {
    get {
      return String(reflecting: value)
    }
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get { return value.hashValue }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! OptionalEnumExtensionField<E>
    return self == o
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
      var v: ValueType?
      try decoder.decodeSingularEnumField(value: &v)
      if let v = v {
          value = v
      }
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType?
    try decoder.decodeSingularEnumField(value: &v)
    if let v = v {
      self.init(protobufExtension: protobufExtension, value: v)
    } else {
      return nil
    }
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    try visitor.visitSingularEnumField(
      value: value,
      fieldNumber: protobufExtension.fieldNumber)
  }
}

///
/// Repeated Enum fields
///
internal struct RepeatedEnumExtensionField<E: Enum>: ExtensionField where E.RawValue == Int {
  internal typealias BaseType = E
  internal typealias ValueType = [E]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: RepeatedEnumExtensionField,
                        rhs: RepeatedEnumExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! RepeatedEnumExtensionField<E>
    return self == o
  }

  internal var debugDescription: String {
    return "[" + value.map{String(reflecting: $0)}.joined(separator: ",") + "]"
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try decoder.decodeRepeatedEnumField(value: &value)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try decoder.decodeRepeatedEnumField(value: &v)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try visitor.visitRepeatedEnumField(
        value: value,
        fieldNumber: protobufExtension.fieldNumber)
    }
  }
}

///
/// Packed Repeated Enum fields
///
/// TODO: This is almost (but not quite) identical to RepeatedEnumFields;
/// find a way to collapse the implementations.
///
internal struct PackedEnumExtensionField<E: Enum>: ExtensionField where E.RawValue == Int {
  internal typealias BaseType = E
  internal typealias ValueType = [E]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: PackedEnumExtensionField,
                        rhs: PackedEnumExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! PackedEnumExtensionField<E>
    return self == o
  }

  internal var debugDescription: String {
    return "[" + value.map{String(reflecting: $0)}.joined(separator: ",") + "]"
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try decoder.decodeRepeatedEnumField(value: &value)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try decoder.decodeRepeatedEnumField(value: &v)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try visitor.visitPackedEnumField(
        value: value,
        fieldNumber: protobufExtension.fieldNumber)
    }
  }
}

//
// ========== Message ==========
//
internal struct OptionalMessageExtensionField<M: Message & Equatable>:
  ExtensionField {
  internal typealias BaseType = M
  internal typealias ValueType = BaseType
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: OptionalMessageExtensionField,
                        rhs: OptionalMessageExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

  internal var debugDescription: String {
    get {
      return String(reflecting: value)
    }
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    value.hash(into: &hasher)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {return value.hashValue}
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! OptionalMessageExtensionField<M>
    return self == o
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    var v: ValueType? = value
    try decoder.decodeSingularMessageField(value: &v)
    if let v = v {
      self.value = v
    }
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType?
    try decoder.decodeSingularMessageField(value: &v)
    if let v = v {
      self.init(protobufExtension: protobufExtension, value: v)
    } else {
      return nil
    }
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    try visitor.visitSingularMessageField(
      value: value, fieldNumber: protobufExtension.fieldNumber)
  }

  internal var isInitialized: Bool {
    return value.isInitialized
  }
}

internal struct RepeatedMessageExtensionField<M: Message & Equatable>:
  ExtensionField {
  internal typealias BaseType = M
  internal typealias ValueType = [BaseType]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: RepeatedMessageExtensionField,
                        rhs: RepeatedMessageExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    for e in value {
      e.hash(into: &hasher)
    }
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! RepeatedMessageExtensionField<M>
    return self == o
  }

  internal var debugDescription: String {
    return "[" + value.map{String(reflecting: $0)}.joined(separator: ",") + "]"
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try decoder.decodeRepeatedMessageField(value: &value)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try decoder.decodeRepeatedMessageField(value: &v)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try visitor.visitRepeatedMessageField(
        value: value, fieldNumber: protobufExtension.fieldNumber)
    }
  }

  internal var isInitialized: Bool {
    return Internal.areAllInitialized(value)
  }
}

//
// ======== Groups within Messages ========
//
// Protoc internally treats groups the same as messages, but
// they serialize very differently, so we have separate serialization
// handling here...
internal struct OptionalGroupExtensionField<G: Message & Hashable>:
  ExtensionField {
  internal typealias BaseType = G
  internal typealias ValueType = BaseType
  internal var value: G
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: OptionalGroupExtensionField,
                        rhs: OptionalGroupExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {return value.hashValue}
#endif  // swift(>=4.2)

  internal var debugDescription: String { get {return value.debugDescription} }

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! OptionalGroupExtensionField<G>
    return self == o
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    var v: ValueType? = value
    try decoder.decodeSingularGroupField(value: &v)
    if let v = v {
      value = v
    }
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType?
    try decoder.decodeSingularGroupField(value: &v)
    if let v = v {
      self.init(protobufExtension: protobufExtension, value: v)
    } else {
      return nil
    }
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    try visitor.visitSingularGroupField(
      value: value, fieldNumber: protobufExtension.fieldNumber)
  }

  internal var isInitialized: Bool {
    return value.isInitialized
  }
}

internal struct RepeatedGroupExtensionField<G: Message & Hashable>:
  ExtensionField {
  internal typealias BaseType = G
  internal typealias ValueType = [BaseType]
  internal var value: ValueType
  internal var protobufExtension: AnyMessageExtension

  internal static func ==(lhs: RepeatedGroupExtensionField,
                        rhs: RepeatedGroupExtensionField) -> Bool {
    return lhs.value == rhs.value
  }

  internal init(protobufExtension: AnyMessageExtension, value: ValueType) {
    self.protobufExtension = protobufExtension
    self.value = value
  }

#if swift(>=4.2)
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
#else  // swift(>=4.2)
  internal var hashValue: Int {
    get {
      var hash = i_2166136261
      for e in value {
        hash = (hash &* i_16777619) ^ e.hashValue
      }
      return hash
    }
  }
#endif  // swift(>=4.2)

  internal var debugDescription: String {
    return "[" + value.map{$0.debugDescription}.joined(separator: ",") + "]"
  }

  internal func isEqual(other: AnyExtensionField) -> Bool {
    let o = other as! RepeatedGroupExtensionField<G>
    return self == o
  }

  internal mutating func decodeExtensionField<D: Decoder>(decoder: inout D) throws {
    try decoder.decodeRepeatedGroupField(value: &value)
  }

  internal init?<D: Decoder>(protobufExtension: AnyMessageExtension, decoder: inout D) throws {
    var v: ValueType = []
    try decoder.decodeRepeatedGroupField(value: &v)
    self.init(protobufExtension: protobufExtension, value: v)
  }

  internal func traverse<V: Visitor>(visitor: inout V) throws {
    if value.count > 0 {
      try visitor.visitRepeatedGroupField(
        value: value, fieldNumber: protobufExtension.fieldNumber)
    }
  }

  internal var isInitialized: Bool {
    return Internal.areAllInitialized(value)
  }
}
