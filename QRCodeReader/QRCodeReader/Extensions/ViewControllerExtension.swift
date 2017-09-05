//
//  ViewControllerExtension.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Hide keyboard when tapping on screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //  If view controller has a collection/tableView this will intercept tap and prevent didSelectRowAtIndexPath to be called
        tap.cancelsTouchesInView = false
    }
    
    // Dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // If the destination view controller is already on the stack, just pop to it
    func didPopTo(_ desType: UIViewController.Type) ->Bool {
        for item in (navigationController?.viewControllers)! {
            if item.isKind(of: desType)  {
                _ = navigationController?.popToViewController(item, animated: true)
                return true
            }
        }
        return false
    }
}
