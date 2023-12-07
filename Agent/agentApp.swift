//
//  abandonApp.swift
//  abandon
//
//  Created by 丁涯 on 2023/12/7.
//

import SwiftUI
import SwiftData

@main
struct agentApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
