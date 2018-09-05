//
//  File.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 25.05.2018.
//

import UIKit.UITableViewCell

public class SelectionOption: ResetableOption {
    public typealias Handler = (Int) -> Void
    public var name: String
    public var segments: [String]
    
    public internal(set) var value: Int {
        didSet {
            self.onChangeHandler?(self.value)
        }
    }
    public internal(set) var defaultValue: Int
    public var onChangeHandler: Handler?
    
    public init(name: String,
                initialValue: Int,
                segments: [String],
                onChangeHandler: @escaping Handler) {
        self.name = name
        self.segments = segments
        self.value = initialValue
        self.defaultValue = initialValue
        self.onChangeHandler = onChangeHandler
    }
    
    public func reset() {
        self.value = defaultValue
    }
}
