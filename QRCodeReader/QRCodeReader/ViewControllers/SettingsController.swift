//
//  SettingsController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

class SettingsController: BasePopupController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: ContentView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var defaultEntityTextField: UITextField!
    @IBOutlet weak var deviceIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.scrollView.backgroundColor = UIColor.clear
        self.mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.showAnimate()
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
    }

    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
        removeAnimate()        
    }
    
    @IBAction func defaultEntityButtonOnTap(_ sender: UIButton) {
    }
    
    
}


