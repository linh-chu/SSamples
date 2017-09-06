//
//  ScanSession.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation

struct ScanSession {
    var id: String = UUID().uuidString
    var name: String = ""
    var organisationId: String = ""
    var entityCode: Int = 0
    var statusCode: Int = 0
    var latitude: Double = 0
    var longitude: Double = 0
    var dateCreated: Date = Date(timeIntervalSinceNow: 0)
    var lastModified: Date = Date(timeIntervalSinceNow: 0)
    
    init() {
        if let settings = AppInstances.settings {
            self.name = settings.name
            self.entityCode = settings.entityCode
            self.organisationId = settings.deviceId
        }
    }
    
    init(statusCode: Int, latitude: Double, longitude: Double) {
        self.init()
        self.statusCode = statusCode
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(id: String, name: String, organisationId: String,
        entityCode: Int, statusCode: Int,
        latitude: Double, longitude: Double,
        dateCreated: Date, lastModified: Date) {
        
        self.id = id
        self.name = name
        self.organisationId = organisationId
        self.entityCode = entityCode
        self.statusCode = statusCode
        self.latitude = latitude
        self.longitude = longitude
        self.dateCreated = dateCreated
        self.lastModified = lastModified
    }
}

extension ScanSession {
    class Coding: NSObject, NSCoding {
        let scanSession: ScanSession?
        
        init(scanSession: ScanSession) {
            self.scanSession = scanSession
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            guard let id = aDecoder.decodeObject(forKey: "id") as? String,
                let name = aDecoder.decodeObject(forKey: "name") as? String,
                let organisationId = aDecoder.decodeObject(forKey: "organisationId") as? String,
                let dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? Date,
                let lastModified = aDecoder.decodeObject(forKey: "lastModified") as? Date else {
                    return nil
            }
            let entityCode = aDecoder.decodeInteger(forKey: "entityCode")
            let statusCode = aDecoder.decodeInteger(forKey: "statusCode")
            let latitude = aDecoder.decodeDouble(forKey: "latitude")
            let longitude = aDecoder.decodeDouble(forKey: "longitude")
            
            scanSession = ScanSession(id: id, name: name, organisationId: organisationId, entityCode: entityCode, statusCode: statusCode, latitude: latitude, longitude: longitude, dateCreated: dateCreated, lastModified: lastModified)
            super.init()
        }
        
        public func encode(with aCoder: NSCoder) {
            guard let scanSession = scanSession else {
                return
            }
            
            aCoder.encode(scanSession.id, forKey: "id")
            aCoder.encode(scanSession.name, forKey: "name")
            aCoder.encode(scanSession.organisationId, forKey: "organisationId")
            aCoder.encode(scanSession.dateCreated, forKey: "dateCreated")
            aCoder.encode(scanSession.lastModified, forKey: "lastModified")
            aCoder.encode(scanSession.entityCode, forKey: "entityCode")
            aCoder.encode(scanSession.statusCode, forKey: "statusCode")
            aCoder.encode(scanSession.latitude, forKey: "latitude")
            aCoder.encode(scanSession.longitude, forKey: "longitude")
        }
    }
}

extension ScanSession: Encodable {
    var encoded: Decodable? {
        return ScanSession.Coding(scanSession: self)
    }
}

extension ScanSession.Coding: Decodable {
    var decoded: Encodable? {
        return self.scanSession
    }
}
