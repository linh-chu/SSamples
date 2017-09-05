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
    
    var mDefaultEntity: LCTupleInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.scrollView.backgroundColor = UIColor.clear
        self.mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.showAnimate()
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            deviceIdTextField.text = uuid
        }
        
        AppMethods.loadSettings()
        if let settings = AppInstances.settings {
            nameTextField.text = settings.name
            if let entity = AppMethods.getEntity(code: settings.entityCode) {
                mDefaultEntity = entity
                defaultEntityTextField.text = entity.value
            }
        }
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
        let name = nameTextField.text
        let entityCode = mDefaultEntity?.key
        let deviceId = deviceIdTextField.text
        
        let settings = Settings(name: name, entityCode: entityCode, deviceId: deviceId)
        AppMethods.saveSettings(settings)
        removeAnimate()
    }

    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func defaultEntityButtonOnTap(_ sender: UIButton) {
        popover(sender, title: "Entities")
    }
    
    func popover(_ sender: UIView, title: String) {
        let popoverInt = PopoverInt(for: sender, title: title) { [unowned self] tuple in
            guard let selectedData = tuple else { return }
            
            self.mDefaultEntity = selectedData
            self.defaultEntityTextField.text = selectedData.value
        }
        popoverInt.dataList = AppInstances.entities
        
        present(popoverInt, animated: true, completion: nil)
    }
}


