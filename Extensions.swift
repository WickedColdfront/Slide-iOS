//
//  Extensions.swift
//  Slide for Reddit
//
//  Created by WickedColdfront on 8/7/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//
// https://www.youtube.com/watch?v=2kwCfFG5fDA
// https://www.youtube.com/watch?v=PNmuTTd5zWc
// https://www.youtube.com/watch?v=DYsfAD01fYk

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
