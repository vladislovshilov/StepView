//
//  StepView.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

@IBDesignable
open class StepView: UIView {
    
    // MARK: - private properties
    private var stepViewWidth: CGFloat {
        return frame.width / CGFloat(numberOfSteps)
    }
    private var stepViews = [StepBaseCircleView]()
    
    // MARK: - public properties
    @IBInspectable var numberOfSteps: Int = 0
    @IBInspectable var selectedStep: Int = 1
    
    @IBInspectable var circleBorderColor: UIColor = .black
    @IBInspectable var circleFilledColor: UIColor = .black
    @IBInspectable var circleRadius: CGFloat = 15
    @IBInspectable var circleBorderWidth: CGFloat = 1
    
    @IBInspectable var selectedCircleBorderColor: UIColor = .black
    @IBInspectable var selectedCircleFilledColor: UIColor = .clear
    @IBInspectable var selectedCircleRadius: CGFloat = 30
    
    @IBInspectable var lineBorderColor: UIColor?
    @IBInspectable var lineBorderHeight: CGFloat = 1
    
    @IBInspectable var textColor: UIColor?
    var textFont = UIFont.systemFont(ofSize: 0)
    var text: String?
    
    // MARK: - init
    convenience init(frame: CGRect,
                     numberOfSteps: Int,
                     circleBorderColor: UIColor) {
        self.init(frame: frame)
        self.numberOfSteps = numberOfSteps
        self.circleBorderColor = circleBorderColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
}

// MARK: - Interface

extension StepView: StepViewContainer {
    func showNextStep() {
        moveTo(step: selectedStep + 1)
    }
    
    func showPreviousStep() {
        moveTo(step: selectedStep - 1)
    }
    
    func moveTo(step: Int) {
        // if step is out of range we return
        if step > numberOfSteps || step < 0 {
            return
        }
        
        // if we move to the next step
        // we change only 2 views to dont redraw all views
        if step > selectedStep && step - selectedStep == 1 {
            createStepView(for: selectedStep-1, in: numberOfSteps, with: step-1)
            createStepView(for: step-1, in: numberOfSteps, with: step-1)
        }
        else {
            selectedStep = step
            createStepViews()
        }
        selectedStep = step
    }
}

// MARK:- Drawing logic

extension StepView {
    override open func draw(_ rect: CGRect) {
        prepareForDraw()
        createStepViews()
    }
    
    private func createStepViews() {
        for index in 0 ..< numberOfSteps {
            createStepView(for: index, in: numberOfSteps, with: selectedStep - 1)
        }
    }
    
    private func createStepView(for index: Int, in viewAmount: Int, with selectedStep: Int) {
        
        // create an abstract object which conforms circle view protocols
        var stepView: ICircleViewDrawable & ILineDrawable
        let stepViewFrame = CGRect(x: CGFloat(index) * stepViewWidth,
                                   y: 0,
                                   width: stepViewWidth,
                                   height: frame.height)
        
        // configure circles radius
        let newRadius = (stepViewWidth / 4) < circleRadius ? stepViewWidth * 0.15 : circleRadius
        let newSelectedRadius = (stepViewWidth / 4) < circleRadius ? newRadius * 2 : selectedCircleRadius
        
        switch index {
        case selectedStep:
            // configure selected step view with text
            let factory = StepTextCircleViewFactory()
            var view = factory.create(frame: stepViewFrame,
                                      circleRadius: newSelectedRadius ,
                                      circleBorderColor: circleBorderColor)
            // you can set your custom text for selected views
            view.text = text ?? "\(index + 1)"
            view.textColor = textColor
            view.textFont = textFont
            view.circleFilledColor = selectedCircleFilledColor
            view.circleBorderColor = selectedCircleBorderColor
            stepView = view
        default:
            // configure other views
            let factory = StepBaseCircleViewFactory()
            stepView = factory.create(frame: stepViewFrame,
                                      circleRadius: newRadius,
                                      circleBorderColor: circleBorderColor)
            // if step of view < selected step
            // fill circle
            stepView.circleFilledColor = index < selectedStep ? circleFilledColor : .clear
            stepView.circleBorderColor = circleBorderColor
        }
        
        // configure view's right and left lines
        stepView.shouldShowLeftLine = index == 0 ? false : true
        stepView.shouldShowRightLine = index == viewAmount - 1 ? false : true
        stepView.lineBorderColor = lineBorderColor ?? circleBorderColor
        stepView.lineBorderHeight = lineBorderHeight
        
        // configure view's circle
        stepView.circleBorderWidth = circleBorderWidth
        
        // insert view in view hierarchy
        replaceView(with: stepView as! StepBaseCircleView, on: index)
    }
    
    // remove view from view hierarchy and insert changed view in its index
    private func replaceView(with view: StepBaseCircleView, on index: Int) {
        if index < stepViews.count {
            willRemoveSubview(stepViews[index])
            stepViews[index].removeFromSuperview()
            stepViews.remove(at: index)
            stepViews.insert(view, at: index)
            
            addSubview(view)
        }
    }
    
    private func prepareForDraw() {
        // remove all previous views
        for view in subviews { view.removeFromSuperview() }
        
        // just populate an array of step views with empty views
        // to correct work of replace method
        let stepViewRect = CGRect(x: 0, y: 0, width: stepViewWidth, height: frame.height)
        self.stepViews = [StepBaseCircleView].init(repeating: StepBaseCircleView(frame: stepViewRect), count: numberOfSteps)
    }
}
