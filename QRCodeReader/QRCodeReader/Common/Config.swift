//
//  Config.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

enum Config {
    
    static let KEY_BATCH_QRCODE: String = "KeyBatchQRCode"
    static let KEY_SCAN_SESSION_LIST: String = "KeyScanSessionList"
}

struct AppInstances {
    
    static var scanSessions = Array<ScanSession>()
    static var scannedCodes = Array<QRCode>()
}
