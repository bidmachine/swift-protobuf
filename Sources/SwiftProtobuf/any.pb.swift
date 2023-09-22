// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: google/protobuf/any.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Protocol Buffers - Google's data interchange format
// Copyright 2008 Google Inc.  All rights reserved.
// https://developers.google.com/protocol-buffers/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import Foundation

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: BidMachineModules.ProtobufAPIVersionCheck {
  struct _2: BidMachineModules.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// `Any` contains an arbitrary serialized protocol buffer message along with a
/// URL that describes the type of the serialized message.
///
/// Protobuf library provides support to pack/unpack Any values in the form
/// of utility functions or additional generated methods of the Any type.
///
/// Example 1: Pack and unpack a message in C++.
///
///     Foo foo = ...;
///     Any any;
///     any.PackFrom(foo);
///     ...
///     if (any.UnpackTo(&foo)) {
///       ...
///     }
///
/// Example 2: Pack and unpack a message in Java.
///
///     Foo foo = ...;
///     Any any = Any.pack(foo);
///     ...
///     if (any.is(Foo.class)) {
///       foo = any.unpack(Foo.class);
///     }
///     // or ...
///     if (any.isSameTypeAs(Foo.getDefaultInstance())) {
///       foo = any.unpack(Foo.getDefaultInstance());
///     }
///
///  Example 3: Pack and unpack a message in Python.
///
///     foo = Foo(...)
///     any = Any()
///     any.Pack(foo)
///     ...
///     if any.Is(Foo.DESCRIPTOR):
///       any.Unpack(foo)
///       ...
///
///  Example 4: Pack and unpack a message in Go
///
///      foo := &pb.Foo{...}
///      any, err := anypb.New(foo)
///      if err != nil {
///        ...
///      }
///      ...
///      foo := &pb.Foo{}
///      if err := any.UnmarshalTo(foo); err != nil {
///        ...
///      }
///
/// The pack methods provided by protobuf library will by default use
/// 'type.googleapis.com/full.type.name' as the type URL and the unpack
/// methods only use the fully qualified type name after the last '/'
/// in the type URL, for example "foo.bar.com/x/y.z" will yield type
/// name "y.z".
///
/// JSON
/// ====
/// The JSON representation of an `Any` value uses the regular
/// representation of the deserialized, embedded message, with an
/// additional field `@type` which contains the type URL. Example:
///
///     package google.profile;
///     message Person {
///       string first_name = 1;
///       string last_name = 2;
///     }
///
///     {
///       "@type": "type.googleapis.com/google.profile.Person",
///       "firstName": <string>,
///       "lastName": <string>
///     }
///
/// If the embedded message type is well-known and has a custom JSON
/// representation, that representation will be embedded adding a field
/// `value` which holds the custom JSON in addition to the `@type`
/// field. Example (for message [google.protobuf.Duration][]):
///
///     {
///       "@type": "type.googleapis.com/google.protobuf.Duration",
///       "value": "1.212s"
///     }
public struct Google_Protobuf_Any {
  // BidMachineModules.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// A URL/resource name that uniquely identifies the type of the serialized
  /// protocol buffer message. This string must contain at least
  /// one "/" character. The last segment of the URL's path must represent
  /// the fully qualified name of the type (as in
  /// `path/google.protobuf.Duration`). The name should be in a canonical form
  /// (e.g., leading "." is not accepted).
  ///
  /// In practice, teams usually precompile into the binary all types that they
  /// expect it to use in the context of Any. However, for URLs which use the
  /// scheme `http`, `https`, or no scheme, one can optionally set up a type
  /// server that maps type URLs to message definitions as follows:
  ///
  /// * If no scheme is provided, `https` is assumed.
  /// * An HTTP GET on the URL must yield a [google.protobuf.Type][]
  ///   value in binary format, or produce an error.
  /// * Applications are allowed to cache lookup results based on the
  ///   URL, or have them precompiled into a binary to avoid any
  ///   lookup. Therefore, binary compatibility needs to be preserved
  ///   on changes to types. (Use versioned type names to manage
  ///   breaking changes.)
  ///
  /// Note: this functionality is not currently available in the official
  /// protobuf release, and it is not used for type URLs beginning with
  /// type.googleapis.com. As of May 2023, there are no widely used type server
  /// implementations and no plans to implement one.
  ///
  /// Schemes other than `http`, `https` (or the empty scheme) might be
  /// used with implementation specific semantics.
  public var typeURL: String {
    get {return _storage._typeURL}
    set {_uniqueStorage()._typeURL = newValue}
  }

  /// Must be a valid serialized protocol buffer of the above specified type.
  public var value: Data {
    get {return _storage._value}
    set {_uniqueStorage()._value = newValue}
  }

  public var unknownFields = BidMachineModules.UnknownStorage()

  public init() {}

  internal var _storage = _StorageClass.defaultInstance
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Google_Protobuf_Any: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "google.protobuf"

extension Google_Protobuf_Any: BidMachineModules.Message, BidMachineModules._MessageImplementationBase, BidMachineModules._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Any"
  public static let _protobuf_nameMap: BidMachineModules._NameMap = [
    1: .standard(proto: "type_url"),
    2: .same(proto: "value"),
  ]

  typealias _StorageClass = AnyMessageStorage

  internal mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: BidMachineModules.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularStringField(value: &_storage._typeURL) }()
        case 2: try { try decoder.decodeSingularBytesField(value: &_storage._value) }()
        default: break
        }
      }
    }
  }

  public func traverse<V: BidMachineModules.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      try _storage.preTraverse()
      if !_storage._typeURL.isEmpty {
        try visitor.visitSingularStringField(value: _storage._typeURL, fieldNumber: 1)
      }
      if !_storage._value.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._value, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Google_Protobuf_Any, rhs: Google_Protobuf_Any) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = lhs._storage.isEqualTo(other: rhs._storage)
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
