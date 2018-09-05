//
//  FloatOption.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 24.05.2018.
//

import Foundation

public class FloatOption: ResetableOption {
    public typealias Handler = (Float) -> Void
    public typealias DefaultValueType = Float
    
    public var name: String
    public var min: Float
    public var max: Float
    public internal(set) var value: Float {
        didSet {
            self.onChangeHandler?(self.value)
        }
    }
    public var onChangeHandler: (Handler)?
    public var needsContinousUpdates: Bool
    
    public var defaultValue: FloatOption.DefaultValueType
    
    public func reset() {
        self.value = defaultValue
    }
    
    public init(name: String, initialValue: Float, min: Float, max: Float, onChangeHandler: @escaping Handler, needsContinousUpdates: Bool = false) {
        self.name = name
        self.min = min
        self.max = max
        self.value = initialValue
        self.onChangeHandler = onChangeHandler
        self.needsContinousUpdates = needsContinousUpdates
        self.defaultValue = initialValue
    }
}
