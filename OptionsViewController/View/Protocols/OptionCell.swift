//
//  OptionCell.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 24.05.2018.
//

public protocol OptionCell: class {
    var style: OptionsViewController.Style { get set }
    
    func configure(for option: Option)
}
