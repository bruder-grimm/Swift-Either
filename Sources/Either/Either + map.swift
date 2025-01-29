//
//  Either + map.swift
//  
//
//  Created by The Northstar✨ System on 2023-08-07.
//

import Foundation



// MARK: - `map`

public extension Either {
    /// Converts this `Either` into another by mapping its value to a different type
    ///
    /// Exactly one of the given closures will be called (the one corresponding to the current value), but the resulting type will still support both new types.
    ///
    /// - Parameters:
    ///   - leftMap:  Maps the curret "left" value to a new value in a new type. Not called if this contains a "right" value.
    ///   - rightMap: Maps the curret "right" value to a new value in a new type. Not called if this contains a "left" value.
    ///
    /// - Returns: A new `Either` with new possible types and a new value
    func map<U, T>(left leftMap: (Left) -> U, right rightMap: (Right) -> T) -> Either<U, T> {
        switch self {
        case .left(let left):
            return .left(leftMap(left))
            
        case .right(let right):
            return .right(rightMap(right))
        }
    }
    
    
    /// Converts the "left" value and type to a new value, optionally of a new type
    ///
    /// - Parameter mapper: Passed the current "left" value, and returns a new value, optionally of a new type
    /// - Returns: A new `Either` containing the same "right" value and type, and a new "left" value andor type
    func map<U>(left mapper: (Left) -> U) -> Either<U, Right> {
        switch self {
        case .left(let left):
            return .left(mapper(left))
            
        case .right(let right):
            return .right(right)
        }
    }
    
    
    /// Converts the "right" value and type to a new value, optionally of a new type
    ///
    /// - Parameter mapper: Passed the current "right" value, and returns a new value, optionally of a new type
    /// - Returns: A new `Either` containing the same "left" value and type, and a new "right" value andor type
    func map<T>(right mapper: (Right) -> T) -> Either<Left, T> {
        switch self {
        case .left(let left):
            return .left(left)
            
        case .right(let right):
            return .right(mapper(right))
        }
    }

    /// We don't have projections, so we provide a foreach with two closures instead
    func foreach(_ left: (Left) -> Void, _ right: (Right) -> Void) {
        switch self {
        case .left(let leftValue):
            left(leftValue)
        case .right(let rightValue):
            right(rightValue)
        }
    }
}



// MARK: - Experimental auto-map

public extension Either {
    
    /// Maps one possible value of this `Either` to a new one. This automatically detects which value to map, left or right.
    ///
    /// Because this might fail to compile if it's ambiguous which side to map, it's marked with an `_`. If field tests prove this to be a non-issue, then future versions might migrate this signature to simply `map(_:)`.
    ///
    /// - Parameter mapper: Maps either the left or the right to a new value (and, optionally, a new type)
    ///
    /// - Returns: A new `Either` with its types remapped
    func _autoMap<U>(_ mapper: (Left) -> U)
    -> Either<U, Right> {
        map(left: mapper)
    }
    
    
    
    /// Maps one possible value of this `Either` to a new one. This automatically detects which value to map, left or right.
    ///
    /// Because this might fail to compile if it's ambiguous which side to map, it's marked with an `_`. If field tests prove this to be a non-issue, then future versions might migrate this signature to simply `map(_:)`.
    ///
    /// - Parameter mapper: Maps either the left or the right to a new value (and, optionally, a new type)
    ///
    /// - Returns: A new `Either` with its types remapped
    func _autoMap<T>(_ mapper: (Right) -> T)
    -> Either<Left, T> {
        map(right: mapper)
    }
}
