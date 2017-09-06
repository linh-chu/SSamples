//
//  QuickScanSaveController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 6/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import MessageUI

class QuickScanSaveController: BasePopupController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: CenterView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    
    var selectedStatus: LCTupleInt? = AppMethods.getStatus(code: 6)
    var currentScanSession: ScanSession?
    var currentQRCode: QRCode?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.scrollView.backgroundColor = UIColor.clear
        self.mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.showAnimate()
        
        statusTextField.text = selectedStatus?.value ?? ""
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
        saveData()
    }
    
    @IBAction func sendButtonOnTap(_ sender: UIButton) {
        sendData()
    }
    
    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func statusButtonOnTap(_ sender: UIButton) {
        popover(sender, title: "Status")
    }
    
    // MARK: - Private Methods
    
    func popover(_ sender: UIView, title: String) {
        let popoverInt = PopoverInt(for: sender, title: title) { [unowned self] tuple in
            guard let selectedData = tuple else { return }
            
            self.selectedStatus = selectedData
            self.statusTextField.text = selectedData.value
        }
        popoverInt.dataList = AppInstances.statuses
        
        present(popoverInt, animated: true, completion: nil)
    }
    
    func saveData() {
        guard var _ = currentQRCode else {
            view.showToast("There was no QR code that has been scanned", backgroundColor: .red)
            return
        }
        
        let statusCode = selectedStatus?.key ?? 0
        currentScanSession = ScanSession(statusCode: statusCode, latitude: 0, longitude: 0)
        currentQRCode?.scanSessionId = currentScanSession!.id
        
        view.showToast("Data has been saved")
    }
    
    func sendData() {
        guard let scanSession = currentScanSession else {
            self.view.showToast("The scan session has not been saved", backgroundColor: .red)
            return
        }
        
        let csvHelper = CSVHelper(target: self, delegate: self)
        csvHelper.exportData([currentQRCode!], scanSession)
    }
}

extension QuickScanSaveController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var message = ""
        if result == .sent {
            message = "Email has been sent"
        } else if result == .cancelled {
            message = "Email has been canceled"
        }
        
        controller.dismiss(animated: true) {
            self.view.showToast(message)
        }
    }
}
