//
//  Entity.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

struct Settings {
    var name: String
    var entityCode: Int
    var deviceId: String
    
    init(name: String?, entityCode: Int?, deviceId: String?) {
        self.name = name ?? ""
        self.entityCode = entityCode ?? 0
        self.deviceId = deviceId ?? ""
    }
}

extension Settings {
    class Coding: NSObject, NSCoding {
        let settings: Settings?
        
        init(settings: Settings) {
            self.settings = settings
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            guard let name = aDecoder.decodeObject(forKey: "name") as? String,
                let entityCode = aDecoder.decodeObject(forKey: "entityCode") as? Int,
                let deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String else {
                    return nil
            }
            settings = Settings(name: name, entityCode: entityCode, deviceId: deviceId)
            super.init()
        }
        
        public func encode(with aCoder: NSCoder) {
            guard let settings = settings else {
                return
            }
            
            aCoder.encode(settings.name, forKey: "name")
            aCoder.encode(settings.entityCode, forKey: "entityCode")
            aCoder.encode(settings.deviceId, forKey: "deviceId")
        }
    }
}

extension Settings: Encodable {
    var encoded: Decodable? {
        return Settings.Coding(settings: self)
    }
}

extension Settings.Coding: Decodable {
    var decoded: Encodable? {
        return self.settings
    }
}
