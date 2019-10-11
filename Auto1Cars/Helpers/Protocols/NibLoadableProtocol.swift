//
//  NibLoadable.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/10/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit
public protocol NibLoadableProtocol: class {
    static var nib: UINib { get }
    static var reusableIdentifier: String { get }
    static func registerSelf(inTableView tableView:UITableView)
}

public extension NibLoadableProtocol {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    static func registerSelf(inTableView tableView:UITableView){
        tableView.register(Self.nib, forCellReuseIdentifier: Self.reusableIdentifier)
    }
}

// MARK: Support for instantiation from NIB
public extension NibLoadableProtocol where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
