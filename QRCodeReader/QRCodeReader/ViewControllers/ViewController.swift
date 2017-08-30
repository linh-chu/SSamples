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
    
    var mQRCodes = Array<QRCode>()

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
        if let data = UserDefaults.standard.object(forKey: Config.KEY_BATCH_QRCODE) as? Array<QRCode> {
            mQRCodes = data
        }
    }
    
    func saveData() {
        
    }
}
