//
//  Util.swift
//  HerdManager
//
//  Created by Linh Chu on 16/1/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation
import UIKit
//import MBProgressHUD

class Utils {
    
    public static let dateFormat1 = "dd/MM/yyyy"
    public static let dateFormat2 = "yyyy-MM-dd"
    public static let dateFormat3 = "yyyyMMdd"
    public static let colorAlternateRow = UIColor(colorLiteralRed: 239/255, green: 241/255, blue: 244/255, alpha: 1)

    static func getString(from date: Date, _ format: String = dateFormat1) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    static func getString(from date: NSDate, _ format: String = dateFormat1) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(for: date)
    }
    
    static func getString(from str: String, _ format: String = dateFormat3) -> String {
        var result = ""
        let items = str.components(separatedBy: "/")
        if items.count >= 3 {
            result = "\(items[2])\(items[1])\(items[0])"
        }
        
        return result
    }
    
    static func getDate(from str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat1
        
        guard let date = dateFormatter.date(from: str) else { return nil }
        return date
    }
    
    static func getNSDate(from str: String) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat1
        
        guard let date = dateFormatter.date(from: str) else { return nil }
        return NSDate(timeInterval: 0, since: date)
    }
    
    static func resizeImage(_ image: inout UIImage, _ targetSize: CGSize){
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    static func rotateImage(_ image: inout UIImage, _ degree: CGFloat) {
        // Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: degree * CGFloat(Double.pi / 180))
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        // Rotate the image context
        bitmap.rotate(by: (degree * CGFloat(Double.pi / 180)))
        
        // Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
//        bitmap.draw(image.cgImage!, in: CGRect(x: -rotatedSize.width / 2, y: -rotatedSize.height / 2, width: rotatedSize.width, height: rotatedSize.height))
        bitmap.draw(image.cgImage!, in: CGRect(x: -image.size.width / 2, y: -image.size.height / 2, width: image.size.width, height: image.size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    static func getDirectory(_ dirName: String, for root: FileManager.SearchPathDirectory = .documentDirectory) -> URL {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: root, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let dirURL = documentsDirectory.appendingPathComponent(dirName)
        var isDir:ObjCBool = true
        
        if !fileManager.fileExists(atPath: dirURL.path, isDirectory: &isDir) {
            do {
                try fileManager.createDirectory(atPath: dirURL.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
        
        return dirURL
    }
    
    static func saveImage(_ image: UIImage, _ fileName: String, to dirName: String, format: String = "png") {
        if let data = UIImagePNGRepresentation(image) {
            let fileURL = getDirectory(dirName).appendingPathComponent("\(fileName).\(format)")
            do {
                try data.write(to: fileURL)
            } catch let error as NSError {
                print("Error writing image: \(error.localizedDescription)")
            }
        }
    }
    
    static func removeImage(_ fileName: String, from dirName: String, format: String = "png") {
        let fileURL = getDirectory(dirName).appendingPathComponent("\(fileName).\(format)")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error as NSError {
                print("Error removing image: \(error.localizedDescription)")
            }
        }
    }
    
    static func loadImage(_ fileName: String, from dirName: String, format: String = "png") -> UIImage? {
        let filePath = getDirectory(dirName).appendingPathComponent("\(fileName).\(format)").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        return nil
    }
    
    // Remove all files in a folder
    static func removeFiles(in dirName: String, for root: FileManager.SearchPathDirectory = .documentDirectory) {
        let fileManager = FileManager.default
        let dirPath = getDirectory(dirName, for: root).path
        var isDir:ObjCBool = true
        
        if fileManager.fileExists(atPath: dirPath, isDirectory: &isDir) {
            do {
                let fileNames = try fileManager.contentsOfDirectory(atPath: dirPath)
                for fileName in fileNames {
                    let filePath = "\(dirPath)/\(fileName)"
                    try fileManager.removeItem(atPath: filePath)
                }
            } catch {
                print("Could not clear temp folder: \(error)")
            }
        }
    }
    
    // Convert hex to UIColor
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // For coloring alternate rows in table view
    static func colorAlternate(_ cell: UITableViewCell, _ row: Int) {
        if row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = colorAlternateRow
        }
    }
    
    static func isValidEmail(_ string: String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
//    static func showHUD(in view: UIView) {
//        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud.bezelView.color = .black
////        hud.bezelView.style = .solidColor
//        hud.contentColor = .white
//        hud.animationType = .zoom
//        hud.isUserInteractionEnabled = false
//    }
//    
//    static func hideHUD(in view: UIView) {
//        MBProgressHUD.hide(for: view, animated: true)
//    }
}
