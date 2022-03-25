//
//  UIView+.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
