//
//  JSValue.Sequence.swift
//  Groupies
//
//  Created by Andrew Bradnan on 3/18/15.
//  Copyright (c) 2015 Microsoft Corp. All rights reserved.
//

import Foundation

public struct JSONArrayGenerator: IteratorProtocol {
    public typealias Element = JSValue
    
    let value: JSValue
    
    var indexInSequence = 0
    
    init(value: JSValue) {
        self.value = value
    }
    
    public mutating func next() -> JSValue? {
        switch value.value {
        case .JSArray(let jsonArray) where !jsonArray.isEmpty:
            if indexInSequence < jsonArray.count {
                let element = jsonArray[indexInSequence]
                indexInSequence += 1
                return element
                
            } else {
                indexInSequence = 0
                return nil
            }
        default:
            return nil
        }
    }
}

extension JSValue: Sequence {
    public func makeIterator() -> JSONArrayGenerator {
        return JSONArrayGenerator(value: self)
    }
}
