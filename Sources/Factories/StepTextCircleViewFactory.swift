//
//  StepTextCircleViewFactory.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

final class StepTextCircleViewFactory: IStepViewCircleFactory {
    typealias StepViewCircle = ITextCircleViewDrawable & ILineDrawable
    
    func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor) -> StepViewCircle {
        return StepTextCircleView(frame: frame,
                                  circleRadius: circleRadius,
                                  circleBorderColor: circleBorderColor)
    }
}
