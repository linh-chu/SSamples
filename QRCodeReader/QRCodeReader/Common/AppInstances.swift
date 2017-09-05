//
//  AppInstances.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

enum AppInstances {
    static var scanSessionList = Array<ScanSession>()
    static var scannedCodeList = Array<QRCode>()
    static var scanSession: ScanSession?
    static var settings: Settings?
    
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
