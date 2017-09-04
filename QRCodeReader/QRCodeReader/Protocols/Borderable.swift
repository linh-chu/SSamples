//
//  ViewBordering.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

protocol Borderable {
    var borderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
}

extension Borderable where Self: UIView {
    
    func addBorder() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        clipsToBounds = cornerRadius > 0
    }
}

class CenterView: UIView, Borderable {
    var borderColor: UIColor = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBorder()
    }
}

class Button: UIButton, Borderable {
    var borderColor: UIColor = .clear
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBorder()
    }
}

