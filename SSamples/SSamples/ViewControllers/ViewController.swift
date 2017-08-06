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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func btnTableViewTapped(_ sender: UIButton) {
        let vcTableView = TableViewController.instantiate(from: .tableView)
        navigationController?.pushViewController(vcTableView, animated: true)
    }
}

