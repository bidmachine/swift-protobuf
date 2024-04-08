// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: google/protobuf/api.proto
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
fileprivate struct _GeneratedWithProtocGenSwiftVersion: BidMachine.ProtobufAPIVersionCheck {
  struct _2: BidMachine.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// Api is a light-weight descriptor for an API Interface.
///
/// Interfaces are also described as "protocol buffer services" in some contexts,
/// such as by the "service" keyword in a .proto file, but they are different
/// from API Services, which represent a concrete implementation of an interface
/// as opposed to simply a description of methods and bindings. They are also
/// sometimes simply referred to as "APIs" in other contexts, such as the name of
/// this message itself. See https://cloud.google.com/apis/design/glossary for
/// detailed terminology.
internal struct Google_Protobuf_Api {
  // BidMachine.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The fully qualified name of this interface, including package name
  /// followed by the interface's simple name.
  internal var name: String = String()

  /// The methods of this interface, in unspecified order.
  internal var methods: [Google_Protobuf_Method] = []

  /// Any metadata attached to the interface.
  internal var options: [Google_Protobuf_Option] = []

  /// A version string for this interface. If specified, must have the form
  /// `major-version.minor-version`, as in `1.10`. If the minor version is
  /// omitted, it defaults to zero. If the entire version field is empty, the
  /// major version is derived from the package name, as outlined below. If the
  /// field is not empty, the version in the package name will be verified to be
  /// consistent with what is provided here.
  ///
  /// The versioning schema uses [semantic
  /// versioning](http://semver.org) where the major version number
  /// indicates a breaking change and the minor version an additive,
  /// non-breaking change. Both version numbers are signals to users
  /// what to expect from different versions, and should be carefully
  /// chosen based on the product plan.
  ///
  /// The major version is also reflected in the package name of the
  /// interface, which must end in `v<major-version>`, as in
  /// `google.feature.v1`. For major versions 0 and 1, the suffix can
  /// be omitted. Zero major versions must only be used for
  /// experimental, non-GA interfaces.
  internal var version: String = String()

  /// Source context for the protocol buffer service represented by this
  /// message.
  internal var sourceContext: Google_Protobuf_SourceContext {
    get {return _sourceContext ?? Google_Protobuf_SourceContext()}
    set {_sourceContext = newValue}
  }
  /// Returns true if `sourceContext` has been explicitly set.
  internal var hasSourceContext: Bool {return self._sourceContext != nil}
  /// Clears the value of `sourceContext`. Subsequent reads from it will return its default value.
  internal mutating func clearSourceContext() {self._sourceContext = nil}

  /// Included interfaces. See [Mixin][].
  internal var mixins: [Google_Protobuf_Mixin] = []

  /// The source syntax of the service.
  internal var syntax: Google_Protobuf_Syntax = .proto2

  internal var unknownFields = BidMachine.UnknownStorage()

  internal init() {}

  fileprivate var _sourceContext: Google_Protobuf_SourceContext? = nil
}

/// Method represents a method of an API interface.
internal struct Google_Protobuf_Method {
  // BidMachine.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The simple name of this method.
  internal var name: String = String()

  /// A URL of the input message type.
  internal var requestTypeURL: String = String()

  /// If true, the request is streamed.
  internal var requestStreaming: Bool = false

  /// The URL of the output message type.
  internal var responseTypeURL: String = String()

  /// If true, the response is streamed.
  internal var responseStreaming: Bool = false

  /// Any metadata attached to the method.
  internal var options: [Google_Protobuf_Option] = []

  /// The source syntax of this method.
  internal var syntax: Google_Protobuf_Syntax = .proto2

  internal var unknownFields = BidMachine.UnknownStorage()

  internal init() {}
}

/// Declares an API Interface to be included in this interface. The including
/// interface must redeclare all the methods from the included interface, but
/// documentation and options are inherited as follows:
///
/// - If after comment and whitespace stripping, the documentation
///   string of the redeclared method is empty, it will be inherited
///   from the original method.
///
/// - Each annotation belonging to the service config (http,
///   visibility) which is not set in the redeclared method will be
///   inherited.
///
/// - If an http annotation is inherited, the path pattern will be
///   modified as follows. Any version prefix will be replaced by the
///   version of the including interface plus the [root][] path if
///   specified.
///
/// Example of a simple mixin:
///
///     package google.acl.v1;
///     service AccessControl {
///       // Get the underlying ACL object.
///       rpc GetAcl(GetAclRequest) returns (Acl) {
///         option (google.api.http).get = "/v1/{resource=**}:getAcl";
///       }
///     }
///
///     package google.storage.v2;
///     service Storage {
///       rpc GetAcl(GetAclRequest) returns (Acl);
///
///       // Get a data record.
///       rpc GetData(GetDataRequest) returns (Data) {
///         option (google.api.http).get = "/v2/{resource=**}";
///       }
///     }
///
/// Example of a mixin configuration:
///
///     apis:
///     - name: google.storage.v2.Storage
///       mixins:
///       - name: google.acl.v1.AccessControl
///
/// The mixin construct implies that all methods in `AccessControl` are
/// also declared with same name and request/response types in
/// `Storage`. A documentation generator or annotation processor will
/// see the effective `Storage.GetAcl` method after inherting
/// documentation and annotations as follows:
///
///     service Storage {
///       // Get the underlying ACL object.
///       rpc GetAcl(GetAclRequest) returns (Acl) {
///         option (google.api.http).get = "/v2/{resource=**}:getAcl";
///       }
///       ...
///     }
///
/// Note how the version in the path pattern changed from `v1` to `v2`.
///
/// If the `root` field in the mixin is specified, it should be a
/// relative path under which inherited HTTP paths are placed. Example:
///
///     apis:
///     - name: google.storage.v2.Storage
///       mixins:
///       - name: google.acl.v1.AccessControl
///         root: acls
///
/// This implies the following inherited HTTP annotation:
///
///     service Storage {
///       // Get the underlying ACL object.
///       rpc GetAcl(GetAclRequest) returns (Acl) {
///         option (google.api.http).get = "/v2/acls/{resource=**}:getAcl";
///       }
///       ...
///     }
internal struct Google_Protobuf_Mixin {
  // BidMachine.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The fully qualified name of the interface which is included.
  internal var name: String = String()

  /// If non-empty specifies a path under which inherited HTTP paths
  /// are rooted.
  internal var root: String = String()

  internal var unknownFields = BidMachine.UnknownStorage()

  internal init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Google_Protobuf_Api: @unchecked Sendable {}
extension Google_Protobuf_Method: @unchecked Sendable {}
extension Google_Protobuf_Mixin: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "google.protobuf"

extension Google_Protobuf_Api: BidMachine.Message, BidMachine._MessageImplementationBase, BidMachine._ProtoNameProviding {
  internal static let protoMessageName: String = _protobuf_package + ".Api"
  internal static let _protobuf_nameMap: BidMachine._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "methods"),
    3: .same(proto: "options"),
    4: .same(proto: "version"),
    5: .standard(proto: "source_context"),
    6: .same(proto: "mixins"),
    7: .same(proto: "syntax"),
  ]

  internal mutating func decodeMessage<D: BidMachine.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.methods) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.options) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.version) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._sourceContext) }()
      case 6: try { try decoder.decodeRepeatedMessageField(value: &self.mixins) }()
      case 7: try { try decoder.decodeSingularEnumField(value: &self.syntax) }()
      default: break
      }
    }
  }

  internal func traverse<V: BidMachine.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.methods.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.methods, fieldNumber: 2)
    }
    if !self.options.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.options, fieldNumber: 3)
    }
    if !self.version.isEmpty {
      try visitor.visitSingularStringField(value: self.version, fieldNumber: 4)
    }
    try { if let v = self._sourceContext {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    if !self.mixins.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.mixins, fieldNumber: 6)
    }
    if self.syntax != .proto2 {
      try visitor.visitSingularEnumField(value: self.syntax, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  internal static func ==(lhs: Google_Protobuf_Api, rhs: Google_Protobuf_Api) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.methods != rhs.methods {return false}
    if lhs.options != rhs.options {return false}
    if lhs.version != rhs.version {return false}
    if lhs._sourceContext != rhs._sourceContext {return false}
    if lhs.mixins != rhs.mixins {return false}
    if lhs.syntax != rhs.syntax {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Google_Protobuf_Method: BidMachine.Message, BidMachine._MessageImplementationBase, BidMachine._ProtoNameProviding {
  internal static let protoMessageName: String = _protobuf_package + ".Method"
  internal static let _protobuf_nameMap: BidMachine._NameMap = [
    1: .same(proto: "name"),
    2: .standard(proto: "request_type_url"),
    3: .standard(proto: "request_streaming"),
    4: .standard(proto: "response_type_url"),
    5: .standard(proto: "response_streaming"),
    6: .same(proto: "options"),
    7: .same(proto: "syntax"),
  ]

  internal mutating func decodeMessage<D: BidMachine.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.requestTypeURL) }()
      case 3: try { try decoder.decodeSingularBoolField(value: &self.requestStreaming) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.responseTypeURL) }()
      case 5: try { try decoder.decodeSingularBoolField(value: &self.responseStreaming) }()
      case 6: try { try decoder.decodeRepeatedMessageField(value: &self.options) }()
      case 7: try { try decoder.decodeSingularEnumField(value: &self.syntax) }()
      default: break
      }
    }
  }

  internal func traverse<V: BidMachine.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.requestTypeURL.isEmpty {
      try visitor.visitSingularStringField(value: self.requestTypeURL, fieldNumber: 2)
    }
    if self.requestStreaming != false {
      try visitor.visitSingularBoolField(value: self.requestStreaming, fieldNumber: 3)
    }
    if !self.responseTypeURL.isEmpty {
      try visitor.visitSingularStringField(value: self.responseTypeURL, fieldNumber: 4)
    }
    if self.responseStreaming != false {
      try visitor.visitSingularBoolField(value: self.responseStreaming, fieldNumber: 5)
    }
    if !self.options.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.options, fieldNumber: 6)
    }
    if self.syntax != .proto2 {
      try visitor.visitSingularEnumField(value: self.syntax, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  internal static func ==(lhs: Google_Protobuf_Method, rhs: Google_Protobuf_Method) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.requestTypeURL != rhs.requestTypeURL {return false}
    if lhs.requestStreaming != rhs.requestStreaming {return false}
    if lhs.responseTypeURL != rhs.responseTypeURL {return false}
    if lhs.responseStreaming != rhs.responseStreaming {return false}
    if lhs.options != rhs.options {return false}
    if lhs.syntax != rhs.syntax {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Google_Protobuf_Mixin: BidMachine.Message, BidMachine._MessageImplementationBase, BidMachine._ProtoNameProviding {
  internal static let protoMessageName: String = _protobuf_package + ".Mixin"
  internal static let _protobuf_nameMap: BidMachine._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "root"),
  ]

  internal mutating func decodeMessage<D: BidMachine.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.root) }()
      default: break
      }
    }
  }

  internal func traverse<V: BidMachine.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.root.isEmpty {
      try visitor.visitSingularStringField(value: self.root, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  internal static func ==(lhs: Google_Protobuf_Mixin, rhs: Google_Protobuf_Mixin) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.root != rhs.root {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
