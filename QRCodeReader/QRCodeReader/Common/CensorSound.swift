//
//  CensorSound.swift
//  QRCodeReader
//
//  Created by Linh Chu on 4/9/17.
//  Copyright © 2017 Philology Pty. Ltd. All rights reserved.
//

import Foundation
import AVFoundation

enum CensorSound {
    
    private static var systemSoundID: SystemSoundID = 2000
   
    // Create a beep system sound id
    static func createBeep() {
        if let soundUrl = Bundle.main.url(forResource: "censor-beep-01", withExtension: "wav") {
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &systemSoundID)
        }
    }
    
    static func disposeBeep() {
        // Dispose the created system sound id
        AudioServicesDisposeSystemSoundID(systemSoundID)
    }
    
    static func playBeep() {
        AudioServicesPlaySystemSound(systemSoundID)
    }
}
