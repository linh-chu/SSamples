//
//  ViewController.swift
//  SSamples
//
//  Created by Linh Chu on 5/8/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnTableView: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var levelsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
//        let queue1 = DispatchQueue(label: "com.example.appname", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main)
//        
//        queue1.async {
//            self.loopManager(printable: "1A") // 1A
//            self.loopManager(printable: "1B") // 1B
//        }
//        
//        // 2
//        DispatchQueue.global().async {
//            self.loopManager(printable: "2A") // 2A
//        }
        
        textView.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        levelsLabel.center = CGPoint(x:levelsLabel.center.x - 500, y:levelsLabel.center.y)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2) {
            self.levelsLabel.center = CGPoint(x:self.levelsLabel.center.x + 500, y:self.levelsLabel.center.y)
            
        }
    }
    
    func animate() {
        
        
        
    }
    
    func loopManager(printable: String) {
        for i in 0...3 {
            doABC(printable: String(i) + ", " + printable)
            sleep(1)
        }
    }
    
    func doABC(printable: String) {
        print(printable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func btnTableViewTapped(_ sender: UIButton) {
        let vcTableView = TableViewController.instantiate(from: .tableView)
        navigationController?.pushViewController(vcTableView, animated: true)
    }
}

