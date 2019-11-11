//
//  LNClipView.swift
//  BeFit
//
//  Created by David Keegan on 10/22/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

import Foundation
import Cocoa
import WebKit

class LNScrollView: NSScrollView {
    private var clipView: LNClipView?
    
    var pattern: NSImage? {
        didSet {
            clipView?.pattern = pattern.flatMap { NSColor(patternImage: $0) }
        }
    }
    
    private func setup() {
        if runningLion() {
            let docView = documentView
            clipView = LNClipView(frame: contentView.frame)
            contentView = clipView!
            documentView = docView
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // this is the cure to fix the scrollers
    // From https://gist.github.com/1608395
    override func hitTest(_ point: NSPoint) -> NSView? {
        guard runningLion() else {
            return super.hitTest(point)
        }
        
        guard let currentEvent = NSApp.currentEvent else {
            return super.hitTest(point)
        }
        
        if currentEvent.type == .leftMouseDown {
            // if we have a vertical scroller and it accepts the current hit
            if hasVerticalScroller && verticalScroller?.hitTest(point) != nil {
                verticalScroller?.mouseDown(with: currentEvent)
                return nil
            }
            
            // if we have a horizontal scroller and it accepts the current hit
            if hasVerticalScroller && horizontalScroller?.hitTest(point) != nil {
                horizontalScroller?.mouseDown(with: currentEvent)
                return nil
            }
        } else if currentEvent.type == .leftMouseUp {
            // if mouse up, just tell both our scrollers we have moused up
            if hasVerticalScroller {
                verticalScroller?.mouseUp(with: currentEvent)
            }
            
            if hasHorizontalScroller {
                horizontalScroller?.mouseUp(with: currentEvent)
            }
            
            return self
        }
        
        return super.hitTest(point)
    }
}

class LNWebView: WebView {
    private var clipView: LNClipView?
    
    var pattern: NSImage? {
        didSet {
            clipView?.pattern = pattern.flatMap { NSColor(patternImage: $0) }
        }
    }
    
    private func setup() {
        if runningLion() {
            let docView = mainFrame.frameView.documentView
            let scrollView = docView?.enclosingScrollView
            clipView = LNWebClipView(frame: scrollView?.contentView.frame ?? .zero)
            scrollView?.contentView = clipView!
            scrollView?.documentView = docView
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

class LNClipView: NSClipView {
    var pattern: NSColor? {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let context = NSGraphicsContext.current else {
            return
        }
        
        context.saveGraphicsState()
        context.patternPhase = NSPoint(x: 0, y: bounds.height)
        
        // pattern
        (pattern ?? .black).set()
        bounds.fill()
        
        // shadow
        let gradient = NSGradient(starting: NSColor(deviceWhite: 0, alpha: 0.2), ending: NSColor.clear)
        
        var gradientRect = bounds
        gradientRect.size.height = 8
        
        if bounds.minY < 0 {
            gradientRect.origin.y += -bounds.minY - gradientRect.height
            gradient?.draw(in: gradientRect, angle: -90)
        } else if bounds.minY > 1 {
            let docRect = enclosingScrollView?.documentView?.frame ?? .zero
            let yOffset = bounds.height - (docRect.height - bounds.minY)
            gradientRect.origin.y += bounds.height - yOffset
            gradient?.draw(in: gradientRect, angle: 90)
        }
        
        context.restoreGraphicsState()
    }
    
    
}

//  From http://www.koders.com/objectivec/fid22DEE7EA2343C20D0FEEC2C079245069DF3E32A5.aspx
class LNWebClipView: LNClipView {
    //  From http://www.koders.com/objectivec/fidD68502CAF940A73CC1E990AF8A2E3D17ACFCD647.aspx
    private var hasAdditionalClip: Bool = false
    private var additionalClip: NSRect = .zero
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // In WebHTMLView, we set a clip. This is not typical to do in an
        // NSView, and while correct for any one invocation of drawRect:,
        // it causes some bad problems if that clip is cached between calls.
        // The cached graphics state, which clip views keep around, does
        // cache the clip in this undesirable way. Consequently, we want to
        // release the GState for all clip views for all views contained in
        // a WebHTMLView. Here we do it for subframes, which use WebClipView.
        // See these bugs for more information:
        // <rdar://problem/3409315>: REGRESSSION (7B58-7B60)?: Safari draws blank frames on macosx.apple.com perf page
        
        //self.releaseGState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func resetAdditionalClip() {
        hasAdditionalClip = false
    }
    
    func setAdditionalClip(_ additionalClip: NSRect) {
        hasAdditionalClip = true
        self.additionalClip = additionalClip
    }
    
    // From https://gist.github.com/b6bcb09a9fc0e9557c27
    override func hitTest(_ point: NSPoint) -> NSView? {
        guard runningLion() else {
            return super.hitTest(point)
        }
        
        guard let currentEvent = NSApp.currentEvent else {
            return super.hitTest(point)
        }
        
        let scrollView = enclosingScrollView
        if currentEvent.type == .leftMouseDown {
            // if we have a vertical scroller and it accepts the current hit
            if scrollView?.hasVerticalScroller ?? false && scrollView?.verticalScroller?.hitTest(point) != nil {
                scrollView?.verticalScroller?.mouseDown(with: currentEvent)
            }
            
            // if we have a horizontal scroller and it accepts the current hit
            if scrollView?.hasVerticalScroller ?? false && scrollView?.horizontalScroller?.hitTest(point) != nil {
                scrollView?.horizontalScroller?.mouseDown(with: currentEvent)
            }
        }
        
        return super.hitTest(point)
    }
}

private func runningLion() -> Bool {
    return floor(NSAppKitVersion.current.rawValue) > NSAppKitVersion.macOS10_6.rawValue
}
