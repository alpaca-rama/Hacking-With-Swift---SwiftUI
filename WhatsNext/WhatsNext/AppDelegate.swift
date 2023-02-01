//
//  AppDelegate.swift
//  WhatsNext
//
//  Created by Luca Capriati on 2022/08/21.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    
    func ShowPopper() {
        guard let statusBarItem = statusItem?.button else { return }
        popover.show(relativeTo: statusBarItem.bounds, of: statusBarItem, preferredEdge: .maxY)
    }
    
    func hidePopover(_ sender: Any) {
        popover.performClose(sender)
    }
    
    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            hidePopover(sender)
        } else {
            ShowPopper()
        }
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "What's Next?"
        statusItem?.button?.action = #selector(togglePopover)
        statusItem?.button?.target = self
        
        let contentView = ContentView()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in guard let self = self else { return }
        
            if self.popover.isShown {
                self.hidePopover(event)
            }
        }
    }
}
