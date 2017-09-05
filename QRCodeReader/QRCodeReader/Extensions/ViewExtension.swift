//
//  View.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

extension UIView {
    
    func showHUD() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.bezelView.color = .black
        //        hud.bezelView.style = .solidColor
        hud.contentColor = .white
        hud.animationType = .zoom
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func showToast(_ message: String, backgroundColor: UIColor = .black, duration: Double = 2.0, position: ToastPosition = .center) {
        var style = ToastStyle()
        var duration = duration
        
        if backgroundColor == UIColor.red {
            style.backgroundColor = backgroundColor
            duration = 3.0
        }
        
        self.makeToast(message, duration: duration, position: position, style: style)
    }
}
