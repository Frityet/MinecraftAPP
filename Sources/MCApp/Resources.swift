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

public let mcFont = NSFont(name: "Minecraft", size: 18)!

let imageCache = NSCache<NSString, NSImage>()

public func getResource(_ name: String) -> NSImage
{
    if let img = imageCache.object(forKey: name as NSString) { return img }

    //Load file relative to `cwd/Resources`
    let path = FileManager.default.currentDirectoryPath + "/Resources/" + name
    let img = NSImage(contentsOfFile: path)!
    imageCache.setObject(img, forKey: name as NSString)
    return img
}

