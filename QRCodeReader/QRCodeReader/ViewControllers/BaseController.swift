//
//  BaseController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification) {}
    
    func keyboardWillHide(_ notification: NSNotification) {}
}

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
