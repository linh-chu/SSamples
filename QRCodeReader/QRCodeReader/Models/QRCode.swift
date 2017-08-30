//
//  QRCode.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

struct QRCode {
    var id: String
    var desc: String
    var location: String
    var dateReceived: Date
    
    init(id: String, desc: String, location: String, dateReceived: Date) {
        self.id = id
        self.desc = desc
        self.location = location
        self.dateReceived = dateReceived
    }
    
    init(id: String, desc: String) {
        self.id = id
        self.desc = desc
        self.location = ""
        self.dateReceived = Date(timeIntervalSinceNow: 0)
    }
}
