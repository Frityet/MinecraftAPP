import Cocoa


@objc
class AppDelegate : NSObject, NSApplicationDelegate {
    private var _controlsView: NSView?       = nil
    private var _counterLabel: NSTextField?  = nil
    private var _counter: UInt64             = 0

    public func applicationDidFinishLaunching(_ notif: Notification)
    {
        let window = MCWindow(title: "MCWindow", style: [.closable, .miniaturizable, .resizable], size: (width: 800, height: 600))
        window.center()
        window.makeKeyAndOrderFront(nil)
        //New view with frame 200px below the top of the window, 120px above the bottom, 100px from the left and right
        //This view will only be used for the controls (GUI elements), so no need to set the background
        _controlsView = NSView(frame: NSRect(x: 100, y: 120, width: window.frame.width - 200, height: window.frame.height - 200))

        //Create a button to increment a counter which is displayed in a label, both should have black text
        //Set the position of these controls to be in the middle of the view
        let button = MCButton(title: "Increment", target: self, action: #selector(incrementCounter))
        //Resize the button to fit the text
        button.sizeToFit()
        button.attributedTitle = NSAttributedString(string: button.title, attributes: [.foregroundColor: NSColor.black])

        button.frame.origin.x = _controlsView!.frame.width / 2 - button.frame.width / 2
        button.frame.origin.y = _controlsView!.frame.height / 2 - button.frame.height / 2

        _controlsView!.addSubview(button)

        //Create a label to display the counter
        _counterLabel = NSTextField(frame: NSRect(x: 0, y: 60, width: 200, height: 50))
        _counterLabel!.font = mcFont
        _counterLabel!.stringValue = "Counter: \(_counter)"
        _counterLabel!.isEditable = false
        _counterLabel!.isSelectable = false
        _counterLabel!.isBordered = false
        _counterLabel!.drawsBackground = false
        _counterLabel!.attributedStringValue = NSAttributedString(string: _counterLabel!.stringValue, attributes: [.foregroundColor: NSColor.black])
        _counterLabel!.sizeToFit()
        _counterLabel!.frame.origin.x = _controlsView!.frame.width / 2 - _counterLabel!.frame.width / 2
        _counterLabel!.frame.origin.y = _controlsView!.frame.height / 2 - _counterLabel!.frame.height / 2 - 60
        _controlsView!.addSubview(_counterLabel!)

        //Add the controls view to the window
        window.contentView!.addSubview(_controlsView!)

        //Make the window the first responder so that the button can be clicked
        window.makeFirstResponder(window)
    }

    public func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool
    {
        return true
    }

    @objc
    private func incrementCounter()
    {
        _counter += 1
        //Update the label preserving the attributes
        _counterLabel!.attributedStringValue = NSAttributedString(string: "Counter: \(_counter)", attributes: [.foregroundColor: NSColor.black])
        _counterLabel!.sizeToFit()
        _counterLabel!.frame.origin.x = _controlsView!.frame.width / 2 - _counterLabel!.frame.width / 2
    }
}

@main
public struct Window {
    public static func main()
    {
        let app = NSApplication.shared
        app.setActivationPolicy(.regular)
        //Make avaibale to be accessed from Accessibility Inspector
        app.setAccessibilityElement(true)

        let delegate = AppDelegate()
        app.delegate = delegate
        app.run()
        // NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    }
}
