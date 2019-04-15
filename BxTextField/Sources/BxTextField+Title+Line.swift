//
//  BxTextField+Title+Line.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 15/04/2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

import UIKit


extension BxTextField {
    
    internal func addLineLayer() {
        lineLayer.masksToBounds = false
        lineLayer.fillColor = nil
        lineLayer.opacity = 1.0
        lineLayer.contentsScale = UIScreen.main.scale
        lineLayer.backgroundColor = UIColor.clear.cgColor
        layoutLineLayer()
        styleLineLayer()
        layer.addSublayer(lineLayer)
    }
    
    internal func layoutLineLayer() {
        let pixelWidth = 1.0 / UIScreen.main.scale
        let textHeight = font?.pointSize ?? 16.0
        let y1 = trunc((bounds.height + textHeight) / 2.0) + pixelWidth * 0.5 + lineSeporatorHeight
        let x2 = bounds.width
        
        linePath.move(to: CGPoint(x: 0, y: y1))
        linePath.addLine(to: CGPoint(x: x2, y: y1))

        lineLayer.frame = bounds
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = lineWidth
    }
    
    internal func styleLineLayer() {
        if let lineColor = self.lineColor {
            lineLayer.strokeColor = lineColor.cgColor
        } else {
            lineLayer.strokeColor = isActive ? activeColor.cgColor : inactiveColor.cgColor
        }
    }
    
    internal func addTitleLayer() {
        titleLayer.masksToBounds = false
        titleLayer.string = title
        titleLayer.contentsScale = UIScreen.main.scale
        titleLayer.backgroundColor = UIColor.clear.cgColor
        layoutTitleLayer()
        styleTitleLayer()
        layer.addSublayer(titleLayer)
    }
    
    internal func layoutTitleLayer() {
        let textHeight = font?.pointSize ?? 16.0
        let height = isTitleAsHint ? titleAsHintFont.pointSize : titleFont.pointSize
        let x = marginSize.width
        let y = isTitleAsHint ? trunc((bounds.height - height) / 2.0) : trunc((bounds.height - textHeight) / 2.0) - height - titleSeporatorHeight
        
        titleLayer.frame = CGRect(x: x, y: y, width: bounds.width, height: height)
    }
    
    internal func styleTitleLayer() {
        let font = isTitleAsHint ? titleAsHintFont : titleFont
        titleLayer.fontSize = font.pointSize
        titleLayer.font = font
        titleLayer.foregroundColor = isActive ? activeColor.cgColor : inactiveColor.cgColor
    }
    
    internal var isNeedUpdateTitle: Bool {
        return isTitleAsHint != isNeedTitleAsHint
    }
    
    internal func updateTitle() {
        styleTitleLayer()
        layoutTitleLayer()
        styleLineLayer()
        layoutLineLayer()
    }
    
    internal func updateTitleAsActive() {
        isActive = true
        isTitleAsHint = false
        updateTitle()
    }
    
    internal var isNeedTitleAsHint : Bool {
        return text?.isEmpty ?? true
    }
    
    internal func updateTitleAsDefault() {
        isActive = false
        isTitleAsHint = isNeedTitleAsHint
        updateTitle()
    }
    
    internal func animateBlock(duration: Double = 0.2, applyHandler: () -> Void) {
        let function = CAMediaTimingFunction(controlPoints: 0.3, 0.0, 0.5, 0.95)
        CATransaction.begin()
        CATransaction.disableActions()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(function)
        applyHandler()
        CATransaction.commit()
    }
    
//    @discardableResult override open func becomeFirstResponder() -> Bool {
//        let becomeFirstResponder = super.becomeFirstResponder()
//        if becomeFirstResponder {
//            animateBlock(applyHandler: updateTitleAsActive)
//        }
//        return becomeFirstResponder
//    }
//
//    @discardableResult override open func resignFirstResponder() -> Bool {
//        let resignFirstResponder = super.resignFirstResponder()
//        if (resignFirstResponder){
//            animateBlock(applyHandler: updateTitleAsDefault)
//        }
//        return resignFirstResponder
//    }
    
}
