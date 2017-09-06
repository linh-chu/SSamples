//
//  QuickScanController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 6/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

class QuickScanController: BaseController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var lblDateReceived: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblBatchId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func copyButtonOnTap(_ sender: UIButton) {
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
    }
}
