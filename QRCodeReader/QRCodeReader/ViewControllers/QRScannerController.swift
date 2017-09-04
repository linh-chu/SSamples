//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet var messageLabel:UILabel!
    
    var audioPlayer:AVAudioPlayer?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var mScanSessionId: String = ""
    
    var systemSoundID: SystemSoundID = 2000
    var hasPlayedSound = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SCAN SESSION"
        
        if let barFrame = navigationController?.navigationBar.frame {
            navigationController?.navigationBar.frame = CGRect(origin: barFrame.origin,
                                                               size: CGSize(width: barFrame.size.width, height: 50))
        }

        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                previewView.addSubview(qrCodeFrameView)
                previewView.bringSubview(toFront: qrCodeFrameView)
            }
            
            // Create a beep system sound id
            if let soundUrl = Bundle.main.url(forResource: "censor-beep-01", withExtension: "wav") {
                AudioServicesCreateSystemSoundID(soundUrl as CFURL, &systemSoundID)
            }
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Reset the preview layer frame
        videoPreviewLayer?.frame = previewView.layer.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    deinit {
        // Dispose the created system sound id
        AudioServicesDisposeSystemSoundID(systemSoundID)
    }
}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            hasPlayedSound = false
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            let metadataValues = metadataObj.stringValue.components(separatedBy: "\n")
            if metadataValues.count >= 4 {
                let batchId = metadataValues[0]
                messageLabel.text = batchId
                if AppInstances.scannedCodeList.filter({ $0.batchId == batchId }).count == 0 {
                    // The QR code being scanned does not exist in the list
                    let qrCode = QRCode(batchId: batchId, scanSessionId: mScanSessionId, desc: metadataValues[1],
                                        location: metadataValues[2], dateReceived: metadataValues[3])
                    AppInstances.scannedCodeList.append(qrCode)
                }
                
                if !hasPlayedSound {
                    AudioServicesPlaySystemSound(systemSoundID)
                    hasPlayedSound = true
                }
            }
        }
    }
    
    
}
