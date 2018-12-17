//
//  StepViewCircleFactory.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit

protocol IStepViewCircleFactory {
    associatedtype StepCircleView
    
    func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor) -> StepCircleView
}
