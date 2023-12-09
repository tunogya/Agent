//
//  Preferences.swift
//  Agent
//
//  Created by 丁涯 on 2023/12/9.
//

import SwiftUI
import Foundation

struct Preferences: View {
    var body: some View {
        VStack {
            Text("Abandon Inc. \(getVersion())\(getBuild())")
        }.frame(width: 400, height: 600)
    }

    func getVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }

    func getBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}

extension AppDelegate {
    @objc func openPreferences() {
        preferences.isReleasedWhenClosed = false // otherwise we crash when opening the window again, WTF?
        preferences.title = "Abandon Agent"
        //preferences.subtitle = "Preferences"
        preferences.contentView = NSHostingView(rootView: Preferences()) // is this how you SwiftUI help I'm scared
        preferences.styleMask = [.titled, .closable]
        preferences.center()
        NSApp.activate(ignoringOtherApps: true)
        preferences.makeKeyAndOrderFront(nil)
    }
}

