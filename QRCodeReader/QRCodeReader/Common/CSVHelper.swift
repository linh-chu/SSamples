//
//  CSVHelper.swift
//  QRCodeReader
//
//  Created by Linh Chu on 5/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import MessageUI

class CSVHelper {
    
    weak var target: UIViewController?
    weak var delegate: MFMailComposeViewControllerDelegate?
    
    init(target: UIViewController, delegate: MFMailComposeViewControllerDelegate) {
        self.target = target
        self.delegate = delegate
    }
    
    func exportScannedList(_ fileName: String, _ scannedList: Array<QRCode>, _ scanSession: ScanSession) {
        // Get path using the temporary directory and file name
        let path = URL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
        
        var csvText = "Trim Date,\(scanSession.dateCreated)\n\n"
        
        let name = scanSession.name
        let dateCreated = scanSession.dateCreated
        let entityValue = AppMethods.getEntity(code: scanSession.entityCode)?.value ?? ""
        let devideId = scanSession.deviceId
        csvText.append("Name:,'\(name),,Date Created:,\(dateCreated),,Entity:,\(entityValue),,Device Id:,\(devideId)\n")
        
        // Add title details
        csvText.append("Batch Id,Description,Location,Date Received\n")
        
        for qrCode in scannedList {
            let batchId = qrCode.batchId
            let desc = qrCode.desc
            let location = qrCode.location
            let dateReceived = qrCode.dateReceived
            
            csvText.append("\(batchId),\(desc),\(location),\(dateReceived)\n")
        }
        
        do {
            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            
            if MFMailComposeViewController.canSendMail() {
                let emailController = MFMailComposeViewController()
                emailController.mailComposeDelegate = self.delegate
                // emailController.setToRecipients([])
                emailController.setSubject("Scan Session - \(name)")
                emailController.setMessageBody("QR code list from \(name) created \(dateCreated)", isHTML: false)
                try emailController.addAttachmentData(Data.init(contentsOf: path), mimeType: "text/csv", fileName: fileName)
                
                target?.present(emailController, animated: true, completion: nil)
            }
        } catch {
            print("Failed to create file: \(error)")
        }
    }
    
    // Use a uniform \n for end of lines.
    func cleanRows(_ file: String) -> String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    // Get a content array in each row
    func getStringFieldsForRow(_ row: String, _ delimiter: String)-> [String]{
        return row.components(separatedBy: delimiter)
    }
    
    // Convert a CSV file to 2 array: columnTitles and data
    func getData(_ filePath: String) -> [[String:String]]{
        // Outlets and properties
        var data:[[String:String]] = [] // an array of dictionaries
        var columnTitles:[String] = []
        
        do {
            // Get file contents
            let contents = try String(contentsOfFile: filePath)
            // Get an array of rows
            let rows = cleanRows(contents).components(separatedBy: "\n")
            
            if rows.count > 0 {
                // Get titles
                columnTitles = getStringFieldsForRow(rows.first!, ",")
                for row in rows.dropFirst() { // Ignore the 1st row (ignore title)
                    let fields = getStringFieldsForRow(row, ",")
                    if fields.count != columnTitles.count {continue}
                    
                    var dataRow = [String:String]()
                    for (index, field) in fields.enumerated() {
                        dataRow[columnTitles[index]] = field
                    }
                    data += [dataRow]
                }
            } else {
                print("No data in file")
            }
        } catch {
        }
        
        return data
    }
}
