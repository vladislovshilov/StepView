//
//  StepBaseCircleView.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

class StepBaseCircleView: UIView {
    
    // MARK: - private properties
    private var path: UIBezierPath!
    private var lineWidth: CGFloat {
        return (frame.width - circleRadius) / 2
    }
    
    // MARK: - public properties
    var circleBorderColor: UIColor = .black
    var circleFilledColor: UIColor = .clear
    var circleRadius: CGFloat = 40
    var circleBorderWidth: CGFloat = 1
    
    var lineBorderColor: UIColor?
    var lineBorderHeight: CGFloat = 1
    var shouldShowLeftLine: Bool = false
    var shouldShowRightLine: Bool = false
    
    // MARK: - init
    
    convenience init(frame: CGRect,
                     circleRadius: CGFloat,
                     circleBorderColor: UIColor) {
        self.init(frame: frame)
        self.circleRadius = circleRadius
        self.circleBorderColor = circleBorderColor
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
        createStepView()
    }
    
    private func createStepView() {
        drawCircle()
        if shouldShowLeftLine { drawLeftLine() }
        if shouldShowRightLine { drawRightLine() }
    }
}

// MARK: - Cirle drawing

extension StepBaseCircleView: ICircleViewDrawable {
    func drawCircle() {
        // create circle bezier path
        path = UIBezierPath(ovalIn: CGRect(x: frame.width / 2 - circleRadius / 2,
                                           y: frame.height / 2 - circleRadius / 2,
                                           width: circleRadius,
                                           height: circleRadius))
        
        // fill circle
        circleFilledColor.setFill()
        path.fill()
        
        // draw circle border
        circleBorderColor.setStroke()
        path.lineWidth = circleBorderWidth
        path.stroke()
    }
}

// MARK: - Lines drawing

extension StepBaseCircleView: ILineDrawable {
    func drawLeftLine() {
        path = UIBezierPath(rect: CGRect(x: 0, y: frame.height / 2, width: lineWidth, height: lineBorderHeight))
        (lineBorderColor ?? circleBorderColor).setFill()
        path.fill()
    }
    
    func drawRightLine() {
        path = UIBezierPath(rect: CGRect(x: lineWidth + circleRadius, y: frame.height / 2, width: lineWidth, height: lineBorderHeight))
        (lineBorderColor ?? circleBorderColor).setFill()
        path.fill()
    }
}
