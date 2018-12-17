//
//  StepViewContainer.swift
//  StepView
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import Foundation

public protocol StepViewContainer {
    var numberOfSteps: Int { get set }
    var selectedStep: Int { get set }
    
    func showNextStep()
    func showPreviousStep()
    func moveTo(step: Int)
}
