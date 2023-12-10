//
//  Menu.swift
//  Agent
//
//  Created by 丁涯 on 2023/12/9.
//

import ScreenCaptureKit

extension AppDelegate: NSMenuDelegate {
    func constructMenu() {
        menu.removeAllItems()
        menu.delegate = self
        
        menu.addItem(NSMenuItem(title: NSLocalizedString("Screen Capture", comment: "Screen Capture"), action: #selector(prepScreenCapture), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: NSLocalizedString("Screen Record", comment: "Screen Record"), action: #selector(prepScreenRecord), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "History", action: #selector(openHistory), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(openPreferences), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: NSLocalizedString("Quit", comment: "Quit"), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }
    
    @objc func openHistory() {
        if let url = URL(string: "https://app.abandon.ai/") {
            NSWorkspace.shared.open(url)
        }
    }
    
    func updateStatusIcon() {
        if let button = statusItem.button {
            if let logoImage = NSImage(named: NSImage.Name("statusBarIcon")) {
                logoImage.size = NSSize(width: 16, height: 16)
                button.image = logoImage
            }
        }
    }
}
