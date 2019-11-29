//
//  PrioritySplitViewDelegate.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/8/19.
//

import Foundation
import Cocoa

class PrioritySplitViewDelegate: NSObject, NSSplitViewDelegate {
    private var lengthsByViewIndex: [Int: CGFloat] = [:]
    private var viewIndicesByPriority: [Int: Int] = [:]
    
    func setMinimumLength(_ minLength: CGFloat, forViewAt viewIndex: Int) {
        lengthsByViewIndex[viewIndex] = minLength
    }
    
    func setPriority(_ priorityIndex: Int, forViewAt viewIndex: Int) {
        viewIndicesByPriority[priorityIndex] = viewIndex
    }
    
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        let subview = splitView.subviews[dividerIndex]
        let subviewFrame = subview.frame
        let frameOrigin: CGFloat
        
        if splitView.isVertical {
            frameOrigin = subviewFrame.origin.x
        } else {
            frameOrigin = subviewFrame.origin.y
        }
        
        let minimumSize = lengthsByViewIndex[dividerIndex] ?? 0
        
        return frameOrigin + minimumSize
    }
    
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        let shrinkingIndex = dividerIndex + 1
        
        guard shrinkingIndex < splitView.subviews.count else {
            assertionFailure()
            return 0
        }
        
        let growingSubview = splitView.subviews[dividerIndex]
        let shrinkingSubview = splitView.subviews[shrinkingIndex]
        let growingSubviewFrame = growingSubview.frame
        let shrinkingSubviewFrame = shrinkingSubview.frame
        let shrinkingSize: CGFloat
        let currentCoordinate: CGFloat
        
        if splitView.isVertical {
            currentCoordinate = growingSubviewFrame.origin.x + growingSubviewFrame.size.width
            shrinkingSize = shrinkingSubviewFrame.size.width
        } else {
            currentCoordinate = growingSubviewFrame.origin.y + growingSubviewFrame.size.height
            shrinkingSize = shrinkingSubviewFrame.size.height
        }
        
        let minimumSize = lengthsByViewIndex[shrinkingIndex] ?? 0
        
        return currentCoordinate + (shrinkingSize - minimumSize)
    }
    
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
        let subviews = splitView.subviews
        let subviewsCount = subviews.count
        let isVertical = splitView.isVertical
        
        var delta = isVertical ?
            (splitView.bounds.size.width - oldSize.width) :
            (splitView.bounds.size.height - oldSize.height)
        
        var viewCountCheck = 0
        
        for priorityIndex in viewIndicesByPriority.keys.sorted() {
            let viewIndexValue = viewIndicesByPriority[priorityIndex] ?? 0
            
            if viewIndexValue >= subviewsCount {
                continue
            }
            
            let view = subviews[viewIndexValue]
            
            var frameSize = view.frame.size
            let minLengthValue = lengthsByViewIndex[viewIndexValue] ?? 0
            
            if isVertical {
                frameSize.height = splitView.bounds.size.height
                if delta > 0 || frameSize.width + delta >= minLengthValue {
                    frameSize.width += delta
                    delta = 0
                } else if delta < 0 {
                    delta += frameSize.width - minLengthValue
                    frameSize.width = minLengthValue
                }
            } else {
                frameSize.width = splitView.bounds.size.width
                if delta > 0 || frameSize.height + delta >= minLengthValue {
                    frameSize.height += delta
                    delta = 0
                } else if delta < 0 {
                    delta += frameSize.height - minLengthValue
                    frameSize.height = minLengthValue
                }
            }
            
            view.setFrameSize(frameSize)
            viewCountCheck += 1
        }
        
        assert(viewCountCheck == subviews.count, "Number of valid views in priority list is less than the subview count of split view \(splitView)")
        assert(abs(delta) < 0.5, "Split view \(splitView) resized smaller than minimum \(isVertical ? "width" : "height") of \(splitView.frame.size.width - delta)")
        
        var offset: CGFloat = 0
        let dividerThickness = splitView.dividerThickness
        
        for subview in subviews {
            let viewFrame = subview.frame
            var viewOrigin = viewFrame.origin
            viewOrigin.x = offset
            subview.setFrameOrigin(viewOrigin)
            offset += viewFrame.size.width + dividerThickness
        }
    }
}
