//
//  Config.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

enum Config {
    
//    static let KEY_BATCH_QRCODE: String = "KeyBatchQRCode"
    static let KEY_SCAN_SESSION_LIST: String = "KeyScanSessionList"

}

enum AppInstances {
    static var scanSessionList = Array<ScanSession>()
    static var scannedCodeList = Array<QRCode>()
    static var scanSession: ScanSession?
    
    static var entities = [LCTupleInt(key: 1, value: "Site A"),
                           LCTupleInt(key: 2, value: "Site B"),
                           LCTupleInt(key: 3, value: "Site C"),
                           LCTupleInt(key: 4, value: "Site D"),
                           LCTupleInt(key: 5, value: "Site E")]
    
    static var statuses = [LCTupleInt(key: 1, value: "CHECK-IN"),
                           LCTupleInt(key: 2, value: "CHECK-OUT"),
                           LCTupleInt(key: 3, value: "SOLD"),
                           LCTupleInt(key: 4, value: "OBSOLETE"),
                           LCTupleInt(key: 5, value: "LOCATION UPDATE")]
}

enum AppMethods {
    
    static func saveScanSessionList() {
        UserDefaults.standard.set(AppInstances.scanSessionList, forKey: Config.KEY_SCAN_SESSION_LIST)
        UserDefaults.standard.synchronize()
    }
    
    static func saveScannedCodeList() {
        if let scanSession = AppInstances.scanSession {
            UserDefaults.standard.set(AppInstances.scannedCodeList, forKey: scanSession.id)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadScanSessionList() {
        if let data = UserDefaults.standard.object(forKey: Config.KEY_SCAN_SESSION_LIST) as? Array<ScanSession> {
            AppInstances.scanSessionList = data
        }
    }
    
    static func loadScannedCodeList(with scanSession: ScanSession) {
        if let data = UserDefaults.standard.object(forKey: scanSession.id) as? Array<QRCode> {
            AppInstances.scannedCodeList = data
        }
    }
}
