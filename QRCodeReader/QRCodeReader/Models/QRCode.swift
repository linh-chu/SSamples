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
    var scanSessionId: String
    var desc: String
    var location: String
    var dateReceived: String
    
    init(batchId: String, scanSessionId: String, desc: String, location: String, dateReceived: String) {
        self.batchId = batchId
        self.scanSessionId = scanSessionId
        self.desc = desc
        self.location = location
        self.dateReceived = dateReceived
    }
    
    init(batchId: String, scanSessionId: String, desc: String) {
        self.batchId = batchId
        self.scanSessionId = scanSessionId
        self.desc = desc
        self.location = ""
        self.dateReceived = ""
    }
}
