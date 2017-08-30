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
    var receivedDate: String
    
    init(id: String, desc: String, location: String, receivedDate: String) {
        self.id = id
        self.desc = desc
        self.location = location
        self.receivedDate = receivedDate
    }
    
    init(id: String, desc: String) {
        self.id = id
        self.desc = desc
        self.location = ""
        self.receivedDate = ""
    }
}
