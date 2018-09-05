//
//  BoolOption.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 24.05.2018.
//

public class BoolOption: ResetableOption {

    public typealias Handler = (Bool) -> Void
    
    public var name: String
    public internal(set) var value: Bool {
        didSet {
            self.onChangeHandler?(self.value)
        }
    }
    public internal(set) var defaultValue: Bool
    public var onChangeHandler: Handler?
    
    public init(name: String, initialValue: Bool, onChangeHandler: @escaping Handler) {
        self.name = name
        self.value = initialValue
        self.defaultValue = initialValue
        self.onChangeHandler = onChangeHandler
    }
    
    public func reset() {
        self.value = defaultValue
    }
}
