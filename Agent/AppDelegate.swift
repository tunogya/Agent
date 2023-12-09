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


class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    let pasteboard = NSPasteboard.general

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
        menu.addItem(NSMenuItem(title: NSLocalizedString("New Movie Recording", comment: "New Movie Recording"), action: #selector(AppDelegate.newMovieRecording), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: NSLocalizedString("New Audio Recording", comment: "New Audio Recording"), action: #selector(AppDelegate.newVideoRecording), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: NSLocalizedString("New Screen Recording", comment: "New Screen Recording"), action: #selector(AppDelegate.newScreenRecording), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "AbandonAI", action: #selector(AppDelegate.abandonai), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: NSLocalizedString("Quit", comment: "Quit"), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusBarItem.menu = menu
    }
    
    @objc func newMovieRecording() {
        print("newMovieRecording")
    }
    
    @objc func newVideoRecording() {
        print("newVideoRecording")
    }
    
    @objc func newScreenRecording() {
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = ["-i", "-r", "-c"]
        task.launch()
        task.waitUntilExit()
        
        // 获取粘贴板中的截屏数据
        if let readData = NSPasteboard.general.data(forType: .tiff),
           let ciImage = CIImage(data: readData) {
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
                // 将 CIImage 转换为 JPEG 数据
                let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
                if let jpegData = bitmapRep.representation(using: .jpeg, properties: [:]) {
                    // 使用 jpegData 上传文件
                    uploadImage(data: jpegData)
                }
            }
        }
    }
    
    @objc func abandonai() {
        if let url = URL(string: "https://app.abandon.ai/") {
            NSWorkspace.shared.open(url)
        }
    }
    
    func uploadImage(data: Data) {
        // 构建你的上传代码
        // 这里将是 HTTP 请求的代码，用于上传到服务器或 OpenAI 的 API 端点
        // 例如:
        // let url = URL(string: "https://api.openai.com/v1/uploads")!
        // var request = URLRequest(url: url)
        // request.httpMethod = "POST"
        // request.setValue("Bearer YOUR_OPENAI_API_KEY", forHTTPHeaderField: "Authorization")
        // request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        // request.httpBody = data // 这里你可能需要构建 multipart/form-data 格式的请求体
        // ...
        // 使用 URLSession 发送请求
        // ...
    }
}
