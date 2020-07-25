//
//  Reusable.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

protocol Reusable: class {
    static func nib() -> UINib
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
