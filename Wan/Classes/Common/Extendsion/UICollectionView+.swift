//
//  UICollectionView+.swift
//  News
//
//  Created by Yang on 2020/4/14.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func xRegister<T: UICollectionViewCell>(_ type: T.Type) where T: CellRegister {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            self.register(type, forCellWithReuseIdentifier: T.identifier)
        }
    }

    func xDequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T where T: CellRegister {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

}
