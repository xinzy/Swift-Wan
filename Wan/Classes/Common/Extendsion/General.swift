//
//  General.swift
//  Gank
//
//  Created by Yang on 2020/4/10.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

protocol CellRegister { }

extension CellRegister {
    static var identifier: String {
        "\(self)"
    }
    
    static var nib: UINib? {
        return UINib(nibName: Self.identifier, bundle: nil)
    }
}

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }

        return view
    }
}

protocol StoryboardLoadable {
    static var storyboard: UIStoryboard { get }
}

extension StoryboardLoadable {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: String(describing: self), bundle: nil)
    }
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self {
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            fatalError("")
        }
        return controller
    }
}
