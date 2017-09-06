//
//  QRCode.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

struct QRCode {
    var batchId: String
    var desc: String
    var entityCode: Int
    var dateReceived: String
    var scanSessionId: String
    
    init(batchId: String, desc: String, location: String, dateReceived: String, scanSessionId: String = "") {
        self.batchId = batchId
        self.desc = desc
        self.entityCode = entityCode
        self.dateReceived = dateReceived
        self.scanSessionId = scanSessionId
    }
    
    init(batchId: String, scanSessionId: String, desc: String) {
        self.batchId = batchId
        self.scanSessionId = scanSessionId
        self.desc = desc
        self.entityCode = 0
        self.dateReceived = ""
    }
}
