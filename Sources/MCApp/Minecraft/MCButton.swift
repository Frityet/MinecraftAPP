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
public class MCButton : NSButton {
    //The minecraft button should have the texture of `Resources/ButtonNormal.png` when not pressed and `Resources/ButtonHovered.png` when hovered over, and `Resources/ButtonPressed.png` when pressed
    //The button should have a black text
    //The button should have a font of "Minecraft"
    private let _trackingArea: NSTrackingArea? = nil
    private let _normalImage = getResource("ButtonNormal.png")
    private let _hoveredImage = getResource("ButtonHover.png")
    private let _pressedImage = getResource("ButtonPressed.png")

    public private(set) var isMouseOver: Bool = false

    //The button is much larger than regular buttons
    public init(title: String, target: AnyObject?, action: Selector?)
    {
        let imgsiz = _normalImage.size
        super.init(frame: NSRect(x: 0, y: 0, width: imgsiz.width, height: imgsiz.height))
        self.title = title
        self.target = target
        self.action = action
        self.font = mcFont
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ dirtyRect: NSRect)
    {
        if _trackingArea == nil {
            let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
            self.addTrackingArea(trackingArea)
        }

        if self.isHighlighted {
            _pressedImage.draw(in: dirtyRect)
        } else if self.isMouseOver {
            _hoveredImage.draw(in: dirtyRect)
        } else {
            _normalImage.draw(in: dirtyRect)
        }

        //Draw the text in white with the minecraft font, reallign to be centered
        //The text itself should have a shadow of black
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.gray
        shadow.shadowBlurRadius = 2
        let text = NSAttributedString(string: self.title, attributes: [.foregroundColor: NSColor.white, .font: mcFont, .shadow: shadow])


        let textRect = NSRect(x: dirtyRect.width / 2 - text.size().width / 2,
                              y: dirtyRect.height / 2 - text.size().height / 2 - 3,
                              width: text.size().width,
                              height: text.size().height)

        text.draw(in: textRect)
    }

    public override func mouseEntered(with event: NSEvent)
    {
        isMouseOver = true
        self.needsDisplay = true
    }

    public override func mouseExited(with event: NSEvent)
    {
        isMouseOver = false
        self.needsDisplay = true
    }

    public override func sizeToFit()
    {
        //Must never change
        self.frame.size = _normalImage.size
    }
}
