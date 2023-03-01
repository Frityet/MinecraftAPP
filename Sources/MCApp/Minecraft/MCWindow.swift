// Copyright (C) 2023 Amrit Bhogal
//
// This file is part of SwiftWindow.
//
// SwiftWindow is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SwiftWindow is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SwiftWindow.  If not, see <http://www.gnu.org/licenses/>.

import Cocoa

//"Invisible" titlebar that will have the close button NSImage(image: 'Resources/CloseButton.png') and the title (font: 'Minecraft', color: black, size: 20)
@objc
public class MCTitleBar : NSView {
    private var _closeButton: NSButton!
    private var _title: MCLabel!

    public init(title: String, window: NSWindow, height: CGFloat)
    {
        super.init(frame: NSRect(x: 0, y: window.frame.height - height, width: window.frame.width, height: height))
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor

        //The title should be in the middle of the titlebar, and the width should just be wide enough to fit the title
        let title = MCLabel(text: title, frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        title.sizeToFit()
        title.frame.origin.x = (window.frame.width - title.frame.width) / 2
        title.frame.origin.y = (height - title.frame.height) / 2

        self.addSubview(title)

        //Should be located in top left corner of titlebar, with a padding of 16
        let closeButton = NSButton(frame: NSRect(x: 0, y: height / 2, width: 32, height: 32))
        //Padding of 16
        closeButton.frame.origin.x = 16
        closeButton.frame.origin.y = (height - closeButton.frame.height) / 2 - 4

        closeButton.image = getResource("CloseButton.png")
        closeButton.imageScaling = .scaleProportionallyUpOrDown
        closeButton.bezelStyle = .shadowlessSquare
        closeButton.isBordered = false
        closeButton.target = window
        closeButton.action = #selector(NSWindow.close)



        self.addSubview(closeButton)
    }

    public required init?(coder: NSCoder)
    { fatalError("init(coder:) has not been implemented") }
}

@objc
public class MCWindow : NSWindow {
    public private(set) var titleBar: MCTitleBar!

    public init(title: String, style: NSWindow.StyleMask, size: (width: CGFloat, height: CGFloat)?)
    {
        let windBackground = getResource("WindowBackground.png")
        super.init(contentRect: NSRect(x: 0, y: 0, width: size?.width ?? windBackground.size.width, height: size?.height ?? windBackground.size.height),
                              styleMask: style,
                              backing: .buffered, defer: false)

        //Segfault fix
        self.isReleasedWhenClosed = false

        self.contentView!.wantsLayer = true
        self.contentView!.layer?.contents = windBackground
        self.contentView!.layer?.contentsGravity = .resize

        //Make the titlebar disabled
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden

        self.isMovableByWindowBackground = true

        //Create the titlebar
        self.titleBar = MCTitleBar(title: title, window: self, height: 64)
        self.contentView!.addSubview(titleBar)
    }
}
