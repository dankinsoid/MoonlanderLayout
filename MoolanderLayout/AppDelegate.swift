//
//  AppDelegate.swift
//  MoolanderLayout
//
//  Created by Данил Войдилов on 24.08.2021.
//

import Cocoa
import SwiftUI
import HotKey

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	let hotKey1 = HotKey(key: .one, modifiers: [.control, .shift])
	let hotKey2 = HotKey(key: .two, modifiers: [.control, .shift])
	let hotKey3 = HotKey(key: .three, modifiers: [.control, .shift])
	let hotKey4 = HotKey(key: .four, modifiers: [.control, .shift])
//	var statusItem: NSStatusItem?
//	let popover = NSPopover()
	private var window: NSWindow?
	private var layout = 0
	private var isOpen = false
	
	override class func awakeFromNib() {}
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		NSApplication.shared.activate(ignoringOtherApps: true)
		
//		statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
//
//		popover.contentViewController = NSHostingController(rootView: ContentView(layer: layout))
//		popover.animates = false
//		if let button = statusItem?.button {
//			button.frame.size = .init(width: NSStatusItem.squareLength, height: NSStatusItem.squareLength)
//			button.image = NSImage(named: NSImage.Name("orex"))
//			button.action = #selector(AppDelegate.togglePopover)
//		}
		
		[hotKey1, hotKey2, hotKey3, hotKey4].enumerated().forEach {
			let i = $0.offset
			$0.element.keyDownHandler = {
				self.layout = i
				self.showPopover(sender: nil)
			}
			$0.element.keyUpHandler = {
				self.closePopover(sender: nil)
			}
		}
		DispatchQueue.main.async {
			NSApplication.shared.keyWindow?.close()
		}
	}
	
//	@objc
//	func togglePopover(sender: Any?) {
//		if popover.isShown {
//			popover.performClose(sender)
//		} else if let button = statusItem?.button {
//			(popover.contentViewController as? NSHostingController<ContentView>)?.rootView = ContentView(layer: layout)
//			popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
//		}
//	}
	
	func showPopover(sender: Any?) {
		let window = window ?? ModalWindow(contentRect: .zero, styleMask: [.borderless], backing: .buffered, defer: false)
		window.backgroundColor = .clear
		window.isOpaque = true
		self.window = window
		window.titlebarAppearsTransparent = true
		if let hosting = window.contentViewController as? NSHostingController<ContentView> {
			hosting.rootView = ContentView(layer: layout)
		} else {
			window.contentViewController = NSHostingController(rootView: ContentView(layer: layout))
		}
		window.center()
		window.isReleasedWhenClosed = false
		NSApp.runModal(for: window)
		isOpen = true
	}
	
	func closePopover(sender: Any?) {
		window?.close()
		isOpen = false
	}
}

final class ModalWindow: NSWindow {
	override func becomeKey() {
		super.becomeKey()
		level = .statusBar
	}
}
