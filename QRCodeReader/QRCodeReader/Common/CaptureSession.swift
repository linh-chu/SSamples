//
//  CaptureSession.swift
//  QRCodeReader
//
//  Created by Linh Chu on 6/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import AVFoundation

protocol CaptureSessionDelegate: class {
    func captureSessionOuput(didNotFindAnyMetadata message: String)
    func captureSessionOuput(didFindAQRCode qrCode: QRCode)
}

class CaptureSession: NSObject {
    
    public weak var delegate: CaptureSessionDelegate?
    public var previewView:UIView
    public var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    fileprivate var captureSession:AVCaptureSession?
    fileprivate var qrCodeFrameView:UIView?
    fileprivate var hasPlayedSound = false
    
    init(_ view: UIView) {
        self.previewView = view
        super.init()
        
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
            videoPreviewLayer?.frame = previewView.layer.bounds
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
            CensorSound.createBeep()
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            debugPrint(error)
            return
        }
    }
    
    deinit {
        // Dispose the created system sound id
        CensorSound.disposeBeep()
        debugPrint("denit CaptureSession")
    }
}

extension CaptureSession: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            hasPlayedSound = false
            qrCodeFrameView?.frame = CGRect.zero
            delegate?.captureSessionOuput(didNotFindAnyMetadata: "No QR code is detected")
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            let metadataValues = metadataObj.stringValue.components(separatedBy: "\n")
            if metadataValues.count >= 4 && !hasPlayedSound {
                // Found a qrcode
                let qrCode = QRCode(batchId: metadataValues[0], desc: metadataValues[1],
                                    location: metadataValues[2], dateReceived: metadataValues[3])
                // Play sound
                CensorSound.playBeep()
                hasPlayedSound = true
                
                delegate?.captureSessionOuput(didFindAQRCode: qrCode)
            }
        }
    }
}

