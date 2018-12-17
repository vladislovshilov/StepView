//
//  StepTextCircleView.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

final class StepTextCircleView: StepBaseCircleView {
    
    // MARK: - private properties
    private var context: CGContext!
    private var fontSize: CGFloat {
        return circleRadius - circleRadius / 4
    }
    
    // MARK: - public properties
    var text: String = ""
    var textColor: UIColor?
    var textFont = UIFont.systemFont(ofSize: 0)
    
    // MARK: - init
    convenience init(frame: CGRect,
                     circleRadius: CGFloat,
                     circleBorderColor: UIColor,
                     text: String) {
        self.init(frame: frame)
        self.circleRadius = circleRadius
        self.circleBorderColor = circleBorderColor
        self.circleBorderWidth = circleBorderWidth * 2
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Drawing logic
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawText()
    }
}

// MARK: - Text drawing

extension StepTextCircleView: ITextCircleViewDrawable {
    func drawText() {
        let textRect = CGRect(x: frame.width / 2 - circleRadius / 2,
                              y: frame.height / 2 - circleRadius / 2,
                              width: circleRadius,
                              height: circleRadius)
        let textContent = text
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let font = UIFont(name: textFont.fontName, size: circleRadius - circleRadius / 3) ?? UIFont.systemFont(ofSize: circleRadius - circleRadius / 3)
        let textFontAttributes = [.font: font,
                                  .foregroundColor: textColor ?? circleBorderColor,
                                  .paragraphStyle: textStyle] as [NSAttributedString.Key: Any]
        
        context = UIGraphicsGetCurrentContext()
        let textTextHeight: CGFloat = textContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity),
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: textFontAttributes,
                                                               context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        
        let textContentRect = CGRect(x: textRect.minX,
                                     y: textRect.minY + (textRect.height - textTextHeight) / 2,
                                     width: textRect.width,
                                     height: textTextHeight)
        textContent.draw(in: textContentRect,
                         withAttributes: textFontAttributes)
        
        context.restoreGState()
    }
}
