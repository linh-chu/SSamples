//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: BaseController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var captureSession: CaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SCAN SESSION"
        
        if let barFrame = navigationController?.navigationBar.frame {
            navigationController?.navigationBar.frame = CGRect(origin: barFrame.origin,
                                                               size: CGSize(width: barFrame.size.width, height: 50))
        }

        captureSession = CaptureSession(previewView)
        captureSession.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Reset the preview layer frame
        captureSession.videoPreviewLayer?.frame = previewView.layer.bounds
    }
    
    deinit {
        debugPrint("denit QRScannerController")
    }
}

extension QRScannerController: CaptureSessionDelegate {
    
    
    func captureSessionOuput(didNotFindAnyMetadata message: String) {
        messageLabel.text = message
    }
    
    func captureSessionOuput(didFindAQRCode qrCode: QRCode) {
        var qrCode = qrCode
        if let scanSession = AppInstances.scanSession {
            // Assign a scan session id to the found qr code if the session is in progress
            qrCode.scanSessionId = scanSession.id
        }
        
        if AppInstances.scannedCodeList.filter({ $0.batchId == qrCode.batchId }).count == 0 {
            // The QR code being scanned does not exist in the list
            AppInstances.scannedCodeList.append(qrCode)
            // Update total label
            totalLabel.text = String(AppInstances.scannedCodeList.count)
        }
        messageLabel.text = qrCode.batchId
    }
}
