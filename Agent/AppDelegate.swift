//
//  AppDelegate.swift
//  abandon
//
//  Created by 丁涯 on 2023/12/7.
//

import SwiftUI
import AppKit
import ScreenCaptureKit


class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusBarItem.button {
            if let logoImage = NSImage(named: NSImage.Name("statusBarIcon")) {
                logoImage.size = NSSize(width: 16, height: 16)
                button.image = logoImage
            }
        }
        
        constructMenu()
    }

    func constructMenu() {
        let menu = NSMenu()
        let streamDisplayMenuItem = NSMenuItem(title: "Stream Display", action: #selector(AppDelegate.selectPortion), keyEquivalent: "A")
        streamDisplayMenuItem.keyEquivalentModifierMask = [.control]
        menu.addItem(streamDisplayMenuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "AbandonAI", action: #selector(AppDelegate.abandonai), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusBarItem.menu = menu
    }
    
    @objc func selectPortion() {
        print("selectPortion")
    }
    
    @objc func abandonai() {
        if let url = URL(string: "https://app.abandon.ai/") {
            NSWorkspace.shared.open(url)
        }
    }
}
