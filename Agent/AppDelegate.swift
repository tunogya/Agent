//
//  AppDelegate.swift
//  abandon
//
//  Created by 丁涯 on 2023/12/7.
//

import SwiftUI
import AppKit


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
        
        menu.addItem(NSMenuItem(title: "Upgrade to Premium", action: #selector(AppDelegate.menuOption1), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "ChatGPT", action: #selector(AppDelegate.menuOption2), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Screen recognition", action: #selector(AppDelegate.menuOption2), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Website", action: #selector(AppDelegate.menuOption2), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusBarItem.menu = menu
    }
    
    @objc func menuOption1() {
        // Handle Option 1
        print("Option 1 Selected")
    }
    
    @objc func menuOption2() {
        // Handle Option 2
        print("Option 2 Selected")
    }
}
