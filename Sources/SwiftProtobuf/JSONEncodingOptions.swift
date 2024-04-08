// Sources/SwiftProtobuf/JSONEncodingOptions.swift - JSON encoding options
//
// Copyright (c) 2014 - 2018 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// JSON encoding options
///
// -----------------------------------------------------------------------------

/// Options for JSONEncoding.
internal struct JSONEncodingOptions {

  /// Always print enums as ints. By default they are printed as strings.
  internal var alwaysPrintEnumsAsInts: Bool = false

  /// Whether to preserve proto field names.
  /// By default they are converted to JSON(lowerCamelCase) names.
  internal var preserveProtoFieldNames: Bool = false

  internal init() {}
}
