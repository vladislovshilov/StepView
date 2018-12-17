//
//  StepBaseCircleViewFactory.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

final class StepBaseCircleViewFactory: IStepViewCircleFactory {
    typealias StepViewCircle = ICircleViewDrawable & ILineDrawable
    
    func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor) -> StepViewCircle {
        return StepBaseCircleView(frame: frame,
                                  circleRadius: circleRadius,
                                  circleBorderColor: circleBorderColor)
    }
}
