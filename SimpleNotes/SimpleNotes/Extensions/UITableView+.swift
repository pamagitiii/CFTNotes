//
//  UITableView+.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

//MARK: - Reuse Identifire extension
protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UITableViewHeaderFooterView: ReuseIdentifiable {}

extension UITableView {
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                for: indexPath) as? T else {
            fatalError("can't dequeue")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_ cellType: T.Type) {
        self.register(cellType, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueHeaderFooterViewCell<T: UITableViewHeaderFooterView>(cellType: T.Type) -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else { fatalError("can't dequeue") }
        return cell
    }
}
