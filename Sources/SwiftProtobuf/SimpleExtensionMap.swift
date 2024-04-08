// Sources/SwiftProtobuf/SimpleExtensionMap.swift - Extension support
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// A default implementation of ExtensionMap.
///
// -----------------------------------------------------------------------------


// Note: The generated code only relies on ExpressibleByArrayLiteral
internal struct SimpleExtensionMap: ExtensionMap, ExpressibleByArrayLiteral, CustomDebugStringConvertible {
    internal typealias Element = AnyMessageExtension

    // Since type objects aren't Hashable, we can't do much better than this...
    internal var fields = [Int: Array<AnyMessageExtension>]()

    internal init() {}

    internal init(arrayLiteral: Element...) {
        insert(contentsOf: arrayLiteral)
    }

    internal init(_ others: SimpleExtensionMap...) {
      for other in others {
        formUnion(other)
      }
    }

    internal subscript(messageType: Message.Type, fieldNumber: Int) -> AnyMessageExtension? {
        get {
            if let l = fields[fieldNumber] {
                for e in l {
                    if messageType == e.messageType {
                        return e
                    }
                }
            }
            return nil
        }
    }

    internal func fieldNumberForProto(messageType: Message.Type, protoFieldName: String) -> Int? {
        // TODO: Make this faster...
        for (_, list) in fields {
            for e in list {
                if e.fieldName == protoFieldName && e.messageType == messageType {
                    return e.fieldNumber
                }
            }
        }
        return nil
    }

    internal mutating func insert(_ newValue: Element) {
        let fieldNumber = newValue.fieldNumber
        if let l = fields[fieldNumber] {
            let messageType = newValue.messageType
            var newL = l.filter { return $0.messageType != messageType }
            newL.append(newValue)
            fields[fieldNumber] = newL
        } else {
            fields[fieldNumber] = [newValue]
        }
    }

    internal mutating func insert(contentsOf: [Element]) {
        for e in contentsOf {
            insert(e)
        }
    }

    internal mutating func formUnion(_ other: SimpleExtensionMap) {
        for (fieldNumber, otherList) in other.fields {
            if let list = fields[fieldNumber] {
                var newList = list.filter {
                    for o in otherList {
                        if $0.messageType == o.messageType { return false }
                    }
                    return true
                }
                newList.append(contentsOf: otherList)
                fields[fieldNumber] = newList
            } else {
                fields[fieldNumber] = otherList
            }
        }
    }

    internal func union(_ other: SimpleExtensionMap) -> SimpleExtensionMap {
        var out = self
        out.formUnion(other)
        return out
    }

    internal var debugDescription: String {
        var names = [String]()
        for (_, list) in fields {
            for e in list {
                names.append("\(e.fieldName):(\(e.fieldNumber))")
            }
        }
        let d = names.joined(separator: ",")
        return "SimpleExtensionMap(\(d))"
    }

}
