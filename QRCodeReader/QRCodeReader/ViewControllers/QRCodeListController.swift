//
//  QRCodeListController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 31/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDateReceived: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblBatchId: UILabel!
    
}

class QRCodeListController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendButtonOnTap(_ sender: UIBarButtonItem) {
    }
    
}

extension QRCodeListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppInstances.scannedCodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QRCodeCell") as! QRCodeTableViewCell
        
        let qrCode = AppInstances.scannedCodeList[indexPath.row]
        cell.lblBatchId.text = qrCode.batchId
        cell.lblDesc.text = qrCode.desc
        cell.lblLocation.text = qrCode.location
        cell.lblDateReceived.text = qrCode.dateReceived
        
        return cell
    }
}
