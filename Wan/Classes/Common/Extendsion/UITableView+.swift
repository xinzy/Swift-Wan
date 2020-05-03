//
//  UITableView+.swift
//  Gank
//
//  Created by Yang on 2020/4/10.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func xRegister<T: UITableViewCell>(_ type: T.Type) where T: CellRegister {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            self.register(type, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func xDequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T where T: CellRegister {
        return self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func reloadSection(_ section: Int, _ animation: UITableView.RowAnimation = .automatic) {
        let indexSet = IndexSet(integer: section)
        self.reloadSections(indexSet, with: animation)
    }

    func reloadRow(_ row: Int, _ section: Int, with animation: RowAnimation = .automatic) {
        let indexPath = IndexPath(row: row, section: section)
        self.reloadRows(at: [indexPath], with: animation)
    }
    
    func deleteRow(_ row: Int, _ section: Int, with animation: RowAnimation = .automatic) {
        let indexPath = IndexPath(row: row, section: section)
        self.deleteRows(at: [indexPath], with: animation)
    }
}
