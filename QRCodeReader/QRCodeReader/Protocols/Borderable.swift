//
//  ViewBordering.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

protocol Borderable {
    var bordercolor: UIColor { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
}

extension Borderable where Self: UIView {
    
    var bordercolor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            } else {
                return UIColor.clear
            }
        }
    }
    
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

class CenterView: UIView, Borderable {
    var bordercolor: UIColor = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 5
}

