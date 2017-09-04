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
    @IBOutlet weak var contentView: CenterView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var defaultEntityTextField: UITextField!
    @IBOutlet weak var deviceIdTextField: UITextField!
    
    let defaultEntity = LCTupleInt(key: 1, value: "Site A")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.scrollView.backgroundColor = UIColor.clear
        self.mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.showAnimate()
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            deviceIdTextField.text = uuid
        }
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
    }

    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func defaultEntityButtonOnTap(_ sender: UIButton) {
        
    }
}


