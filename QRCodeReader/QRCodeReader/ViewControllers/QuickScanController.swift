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
    @IBOutlet weak var lblEntity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblBatchId: UILabel!
    
    var captureSession: CaptureSession!
    var currentQRCode: QRCode?
    var clipboard: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "QUICK SCAN"
        
        captureSession = CaptureSession(previewView)
        captureSession.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Reset the preview layer frame
        captureSession.videoPreviewLayer?.frame = previewView.layer.bounds
    }
    
    deinit {
        debugPrint("denit QuickScanController")
    }

    @IBAction func copyButtonOnTap(_ sender: UIButton) {
        copyToClipboard()
    }

    @IBAction func saveButtonOnTap(_ sender: UIButton) {
        popUpQuickScanSaveVC()
    }
    
    @IBAction func cancelButtonOnTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    func reloadDetails() {
        if let qrCode = currentQRCode {
            lblBatchId.text = qrCode.batchId
            lblDesc.text = qrCode.desc
            lblEntity.text = qrCode.site
            lblDateReceived.text = qrCode.dateReceived
        } else {
            lblBatchId.text = ""
            lblDesc.text = ""
            lblEntity.text = ""
            lblDateReceived.text = ""
        }
    }
    
    func copyToClipboard() {
        guard let qrCode = currentQRCode else {
            clipboard = ""
            return
        }

        // Append qr code details
        var text = "Batch Id: \(qrCode.batchId)" +
                    "\nDescription: \(qrCode.desc)" +
                    "\nEntity: \(qrCode.site)" +
                    "\nDate Received: \(qrCode.dateReceived)"
        
        // Append current settings
        if let settings = AppInstances.settings {
            let entityValue = AppMethods.getEntity(code: settings.entityCode)?.value ?? ""
            
            text.append("\nName: \(settings.name)")
            text.append("\nDefault Entity: \(entityValue)")
            text.append("\nOrganisation ID: \(settings.deviceId)")
        }
        
        // Append status
        text.append("\nStatus: QUICK SCAN")
        
        // Copy to clipboard
        UIPasteboard.general.string = text
        view.showToast("Copied to clipboard")
    }
    
    // Pop up Quick Scan Save view controller
    func popUpQuickScanSaveVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quickScanSaveVC = storyboard.instantiateViewController(withIdentifier :"QuickScanSaveViewController") as! QuickScanSaveController
        quickScanSaveVC.currentQRCode = currentQRCode
        self.addChildViewController(quickScanSaveVC)
        self.view.addSubview(quickScanSaveVC.view)
        quickScanSaveVC.view.frame = self.view.frame
        quickScanSaveVC.didMove(toParentViewController: self)
    }
}

extension QuickScanController: CaptureSessionDelegate {
    
    func captureSessionOuput(didNotFindAnyMetadata message: String) {
        
    }
    
    func captureSessionOuput(didFindAQRCode qrCode: QRCode) {
        currentQRCode = qrCode
        reloadDetails()
    }
}
