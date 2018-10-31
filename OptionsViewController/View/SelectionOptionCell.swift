//
//  SelectionOptionCell.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 25.05.2018.
//

import UIKit.UITableViewCell

class SelectionOptionCell: UITableViewCell, OptionCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var option: SelectionOption?
    var style: OptionsViewController.Style = .init() {
        didSet {
            self.setStyle()
        }
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        self.option?.value = sender.selectedSegmentIndex
    }
    
    func configure(for option: Option) {
        guard let sOption = option as? SelectionOption else {
            return
        }
        
        self.segmentedControl.removeAllSegments()
        for i in 0..<sOption.segments.count {
            self.segmentedControl.insertSegment(withTitle: sOption.segments[i],
                                                at: i,
                                                animated: false)
        }
        
        self.segmentedControl.selectedSegmentIndex = sOption.value
        
        self.name.text = option.name
        
        self.option = sOption
        self.selectionStyle = .none
    }
    
    public func setStyle() {
        self.backgroundColor = self.style.cellBackgroundColor
        self.contentView.backgroundColor = self.style.cellBackgroundColor
        self.name.textColor = self.style.cellTitleColor
        self.segmentedControl.tintColor = self.style.cellAccessoryColor
    }
    
}
