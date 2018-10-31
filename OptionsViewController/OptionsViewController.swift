//
//  UserOptionsViewController.swift
//  DebugMenu
//
//  Created by Andrey Volodin on 24.05.2018.
//

import UIKit

extension NSObject {
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        return self.nameOfClass
    }
}

extension UITableView {
    func registerCellWithNib<T>(cell: T.Type) where T: UITableViewCell {
        let identifier = cell.reuseIdentifier()
        let nib = UINib(nibName: identifier, bundle: Bundle(for: cell))
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T>(cell: T.Type) -> T? where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier()) as? T
    }
}

public class OptionsViewController: UITableViewController {
    
    public class Style {
        public var cellBackgroundColor: UIColor = .darkGray
        public var cellTitleColor: UIColor = .white
        public var cellValueColor: UIColor = .white
        public var cellAccessoryColor: UIColor = .lightGray
        
        public init() {}
    }
    
    public var style: Style
    
    public var options: [Option] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    public init(style: OptionsViewController.Style) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var registeredTypes: [ObjectIdentifier: UITableViewCell.Type] = [:]
    
    fileprivate func register(cellType: UITableViewCell.Type, for modelType: Option.Type) {
        let typeId = ObjectIdentifier(modelType)
        self.registeredTypes[typeId] = cellType
    }
    
    fileprivate func cellType(for modelType: Option.Type) -> UITableViewCell.Type? {
        let typeId = ObjectIdentifier(modelType)
        return self.registeredTypes[typeId]
    }
    
    public func resetToDefaults() {
        options.forEach { ($0 as? ResetableOption)?.reset() }
        tableView.reloadData()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerCellWithNib(cell: BoolOptionCell.self)
        self.tableView.registerCellWithNib(cell: FloatOptionCell.self)
        self.tableView.registerCellWithNib(cell: SelectionOptionCell.self)
        
        self.register(cellType: BoolOptionCell.self, for: BoolOption.self)
        self.register(cellType: FloatOptionCell.self, for: FloatOption.self)
        self.register(cellType: SelectionOptionCell.self, for: SelectionOption.self)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 140
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User options"
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentOption = options[indexPath.row]
        
        guard
            let cellType = self.cellType(for: type(of: currentOption)),
            let cell = self.tableView.dequeueCell(cell: cellType) as? OptionCell
        else {
            return UITableViewCell()
        }
        cell.configure(for: currentOption)
        cell.style = self.style
        
        return cell as? UITableViewCell ?? UITableViewCell()
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
