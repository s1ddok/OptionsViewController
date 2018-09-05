//
//  FloatOptionCell.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 24.05.2018.
//

import UIKit.UITableViewCell

class FloatOptionCell: UITableViewCell, OptionCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!
    
    var style: OptionsViewController.Style = .init() {
        didSet {
            self.setStyle()
        }
    }
    
    var option: FloatOption?
    
    @IBAction func valueChanged(_ sender: UISlider) {
        self.valueLabel.text = "\(slider.value)"
        
        if let fo = self.option,
           fo.needsContinousUpdates {
            fo.value = sender.value
        }
    }
    
    @IBAction func touchDragExit(_ sender: UISlider) {
        self.option?.value = sender.value
    }
    
    func configure(for option: Option) {
        guard let fOption = option as? FloatOption else {
            return
        }
        
        self.slider.minimumValue = fOption.min
        self.slider.maximumValue = fOption.max
        self.slider.value = fOption.value
        
        self.valueLabel.text = "\(fOption.value)"
        self.name.text = option.name
        
        self.option = fOption
        self.selectionStyle = .none
    }

    fileprivate func setStyle() {
        self.backgroundColor = self.style.cellBackgroundColor
        self.contentView.backgroundColor = self.style.cellBackgroundColor
        self.name.textColor = self.style.cellTitleColor
        self.slider.tintColor = self.style.cellAccessoryColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
}
