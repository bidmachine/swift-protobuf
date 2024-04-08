// Sources/SwiftProtobuf/FieldTypes.swift - Proto data types
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Serialization/deserialization support for each proto field type.
///
/// Note that we cannot just extend the standard Int32, etc, types
/// with serialization information since proto language supports
/// distinct types (with different codings) that use the same
/// in-memory representation.  For example, proto "sint32" and
/// "sfixed32" both are represented in-memory as Int32.
///
/// These types are used generically and also passed into
/// various coding/decoding functions to provide type-specific
/// information.
///
// -----------------------------------------------------------------------------

import Foundation

// TODO: `FieldType` and `FieldType.BaseType` should require `Sendable` but we cannot do so yet without possibly breaking compatibility.

// Note: The protobuf- and JSON-specific methods here are defined
// in ProtobufTypeAdditions.swift and JSONTypeAdditions.swift
internal protocol FieldType {
    // The Swift type used to store data for this field.  For example,
    // proto "sint32" fields use Swift "Int32" type.
    associatedtype BaseType: Hashable

    // The default value for this field type before it has been set.
    // This is also used, for example, when JSON decodes a "null"
    // value for a field.
    static var proto3DefaultValue: BaseType { get }

    // Generic reflector methods for looking up the correct
    // encoding/decoding for extension fields, map keys, and map
    // values.
    static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws
    static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws
    static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws
    static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws
    static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws
}

///
/// Marker protocol for types that can be used as map keys
///
internal protocol MapKeyType: FieldType {
    /// A comparison function for where order is needed.  Can't use `Comparable`
    /// because `Bool` doesn't conform, and since it is `public` there is no way
    /// to add a conformance internal to BidMachine.
    static func _lessThan(lhs: BaseType, rhs: BaseType) -> Bool
}

// Default impl for anything `Comparable`
extension MapKeyType where BaseType: Comparable {
    internal static func _lessThan(lhs: BaseType, rhs: BaseType) -> Bool {
        return lhs < rhs
    }
}

///
/// Marker Protocol for types that can be used as map values.
///
internal protocol MapValueType: FieldType {
}

//
// We have a struct for every basic proto field type which provides
// serialization/deserialization support as static methods.
//

///
/// Float traits
///
internal struct ProtobufFloat: FieldType, MapValueType {
    internal typealias BaseType = Float
    internal static var proto3DefaultValue: Float {return 0.0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFloatField(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFloatField(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularFloatField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedFloatField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedFloatField(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Double
///
internal struct ProtobufDouble: FieldType, MapValueType {
    internal typealias BaseType = Double
    internal static var proto3DefaultValue: Double {return 0.0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularDoubleField(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedDoubleField(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularDoubleField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedDoubleField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedDoubleField(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Int32
///
internal struct ProtobufInt32: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int32
    internal static var proto3DefaultValue: Int32 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularInt32Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedInt32Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedInt32Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Int64
///

internal struct ProtobufInt64: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int64
    internal static var proto3DefaultValue: Int64 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularInt64Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedInt64Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedInt64Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// UInt32
///
internal struct ProtobufUInt32: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = UInt32
    internal static var proto3DefaultValue: UInt32 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularUInt32Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedUInt32Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularUInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedUInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedUInt32Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// UInt64
///

internal struct ProtobufUInt64: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = UInt64
    internal static var proto3DefaultValue: UInt64 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularUInt64Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedUInt64Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularUInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedUInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedUInt64Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// SInt32
///
internal struct ProtobufSInt32: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int32
    internal static var proto3DefaultValue: Int32 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSInt32Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSInt32Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularSInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedSInt32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedSInt32Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// SInt64
///

internal struct ProtobufSInt64: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int64
    internal static var proto3DefaultValue: Int64 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSInt64Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSInt64Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularSInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedSInt64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedSInt64Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Fixed32
///
internal struct ProtobufFixed32: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = UInt32
    internal static var proto3DefaultValue: UInt32 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFixed32Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFixed32Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularFixed32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedFixed32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedFixed32Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Fixed64
///
internal struct ProtobufFixed64: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = UInt64
    internal static var proto3DefaultValue: UInt64 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFixed64Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFixed64Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularFixed64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedFixed64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedFixed64Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// SFixed32
///
internal struct ProtobufSFixed32: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int32
    internal static var proto3DefaultValue: Int32 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSFixed32Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSFixed32Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularSFixed32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedSFixed32Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedSFixed32Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// SFixed64
///
internal struct ProtobufSFixed64: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Int64
    internal static var proto3DefaultValue: Int64 {return 0}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSFixed64Field(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSFixed64Field(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularSFixed64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedSFixed64Field(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedSFixed64Field(value: value, fieldNumber: fieldNumber)
    }
}

///
/// Bool
///
internal struct ProtobufBool: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = Bool
    internal static var proto3DefaultValue: Bool {return false}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularBoolField(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedBoolField(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularBoolField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedBoolField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitPackedBoolField(value: value, fieldNumber: fieldNumber)
    }

    /// Custom _lessThan since `Bool` isn't `Comparable`.
    internal static func _lessThan(lhs: BaseType, rhs: BaseType) -> Bool {
        if !lhs {
            return rhs
        }
        return false
    }
}

///
/// String
///
internal struct ProtobufString: FieldType, MapKeyType, MapValueType {
    internal typealias BaseType = String
    internal static var proto3DefaultValue: String {return String()}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularStringField(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedStringField(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularStringField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedStringField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        assert(false)
    }
}

///
/// Bytes
///
internal struct ProtobufBytes: FieldType, MapValueType {
    internal typealias BaseType = Data
    internal static var proto3DefaultValue: Data {return Data()}
    internal static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularBytesField(value: &value)
    }
    internal static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedBytesField(value: &value)
    }
    internal static func visitSingular<V: Visitor>(value: BaseType, fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitSingularBytesField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitRepeated<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        try visitor.visitRepeatedBytesField(value: value, fieldNumber: fieldNumber)
    }
    internal static func visitPacked<V: Visitor>(value: [BaseType], fieldNumber: Int, with visitor: inout V) throws {
        assert(false)
    }
}
