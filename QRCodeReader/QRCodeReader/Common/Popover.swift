//
//  Popover.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation
import LCUIComponents

typealias LCTupleInt = LCTuple<Int>

class PopoverInt: LCPopover<Int> {
    
    override init(for view: UIView, title: String, didSelectDataHandler: (((key: Int, value: String)?) -> ())?) {
        super.init(for: view, title: title, didSelectDataHandler: didSelectDataHandler)
        
//        backgroundColor = Config.COLOR_MAIN
//        borderColor = Config.COLOR_MAIN
//        titleColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

