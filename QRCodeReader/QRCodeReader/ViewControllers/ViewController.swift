//
//  ViewController.swift
//  QRCodeReader
//
//  Created by Linh Chu on 30/8/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var mScanSessions = Array<ScanSession>()
    var mScannedCodes = Array<QRCode>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnViewListTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Private Methods
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: Config.KEY_SCAN_SESSION_LIST) as? Array<ScanSession> {
            AppInstances.scanSessionList = data
        }
    }
    
    func saveData() {
        
        if let scanSession = AppInstances.scanSession {
            UserDefaults.standard.set(AppInstances.scannedCodeList, forKey: scanSession.id)
            UserDefaults.standard.synchronize()
        }
    }
}
