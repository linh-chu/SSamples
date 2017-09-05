//
//  AppMethods.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

enum AppMethods {
    
    static func saveScanSessionList() {
        UserDefaults.standard.set(AppInstances.scanSessionList, forKey: Config.KEY_SCAN_SESSION_LIST)
        UserDefaults.standard.synchronize()
    }
    
    static func loadScanSessionList() {
        if let data = UserDefaults.standard.object(forKey: Config.KEY_SCAN_SESSION_LIST) as? Array<ScanSession> {
            AppInstances.scanSessionList = data
        }
    }
    
    static func saveScannedCodeList() {
        if let scanSession = AppInstances.scanSession {
            UserDefaults.standard.set(AppInstances.scannedCodeList, forKey: scanSession.id)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadScannedCodeList(with scanSession: ScanSession) {
        if let data = UserDefaults.standard.object(forKey: scanSession.id) as? Array<QRCode> {
            AppInstances.scannedCodeList = data
        }
    }
    
    static func saveSettings(_ settings: Settings) {
        if let encodedData = settings.encoded {
            let data = NSKeyedArchiver.archivedData(withRootObject: encodedData)
            UserDefaults.standard.set(data, forKey: Config.KEY_SETTINGS)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadSettings() {
        if let data = UserDefaults.standard.object(forKey: Config.KEY_SETTINGS) as? Data {
            if let decodedData = (NSKeyedUnarchiver.unarchiveObject(with: data) as? Settings.Coding)?.decoded as? Settings {
                AppInstances.settings = decodedData
            }
        }
    }
}
