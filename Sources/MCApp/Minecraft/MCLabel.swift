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

@objc
public class MCLabel : NSTextField {
    public init(text: String, frame: NSRect, size: Int = 42, colour: NSColor = .black)
    {
        super.init(frame: frame)
        self.stringValue = text
        self.isEditable = false
        self.isSelectable = false
        self.drawsBackground = false
        self.isBordered = false
        self.textColor = colour
        //Set the text size
        self.font = NSFont(name: mcFont.fontName, size: CGFloat(size))!

        //Add shadow
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.lightGray
        shadow.shadowBlurRadius = 2
        shadow.shadowOffset = NSSize(width: 0, height: -1)
        self.shadow = shadow
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
