// Sources/SwiftProtobuf/ProtobufMap.swift - Map<> support
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Generic type representing proto map<> fields.
///
// -----------------------------------------------------------------------------

import Foundation

/// SwiftProtobuf Internal: Support for Encoding/Decoding.
internal struct _ProtobufMap<KeyType: MapKeyType, ValueType: FieldType>
{
    internal typealias Key = KeyType.BaseType
    internal typealias Value = ValueType.BaseType
    internal typealias BaseType = Dictionary<Key, Value>
}

/// SwiftProtobuf Internal: Support for Encoding/Decoding.
internal struct _ProtobufMessageMap<KeyType: MapKeyType, ValueType: Message & Hashable>
{
    internal typealias Key = KeyType.BaseType
    internal typealias Value = ValueType
    internal typealias BaseType = Dictionary<Key, Value>
}

/// SwiftProtobuf Internal: Support for Encoding/Decoding.
internal struct _ProtobufEnumMap<KeyType: MapKeyType, ValueType: Enum>
{
    internal typealias Key = KeyType.BaseType
    internal typealias Value = ValueType
    internal typealias BaseType = Dictionary<Key, Value>
}
