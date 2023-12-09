//
//  AppDelegate.swift
//  abandon
//
//  Created by 丁涯 on 2023/12/7.
//

import SwiftUI
import AppKit
import Cocoa
import CoreImage
import ScreenCaptureKit
import AVFoundation
import AVFAudio

class AppDelegate: NSObject, NSApplicationDelegate, SCStreamDelegate, SCStreamOutput {
    var vW: AVAssetWriter!
    var vwInput, awInput: AVAssetWriterInput!
    var startTime: Date?
    var stream: SCStream!
    var filePath: String!
    var audioFile: AVAudioFile?
    var audioSettings: [String : Any]!
    var availableContent: SCShareableContent?
    var filter: SCContentFilter?
    var updateTimer: Timer?

    var screen: SCDisplay?
    var window: SCWindow?
//    var streamType: StreamType?
    
    var statusItem: NSStatusItem!
    var menu = NSMenu()
    let pasteboard = NSPasteboard.general
    
    let preferences = NSWindow()
    let ud = UserDefaults.standard

    func applicationDidFinishLaunching(_ notification: Notification) {
        lazy var userDesktop = (NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true) as [String]).first!
        
        // the `com.apple.screencapture` domain has the user set path for where they want to store screenshots or videos
        let saveDirectory = (UserDefaults(suiteName: "com.apple.screencapture")?.string(forKey: "location") ?? userDesktop) as NSString
        
        ud.register( // default defaults (used if not set)
            defaults: [
//                "audioFormat": AudioFormat.aac.rawValue,
//                "audioQuality": AudioQuality.high.rawValue,
//                "frameRate": 60,
//                "videoFormat": VideoFormat.mp4.rawValue,
//                "encoder": Encoder.h264.rawValue,
                "saveDirectory": saveDirectory,
//                "hideSelf": false,
//                "showMouse": true
            ]
        )
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        updateStatusIcon()
        
        statusItem.menu = menu
        menu.minimumWidth = 250
        constructMenu()
    }
    
    func requestPermissions() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "Azayaka needs permissions!"
            alert.informativeText = "Azayaka needs screen recording permissions, even if you only intend on recording audio."
            alert.addButton(withTitle: "Open Settings")
            alert.addButton(withTitle: "No thanks, quit")
            alert.alertStyle = .informational
            if alert.runModal() == .alertFirstButtonReturn {
                NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!)
            }
            NSApp.terminate(self)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        if stream != nil {
//            stopRecording()
        }
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
