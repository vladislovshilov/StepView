//
//  ContainerViewController.swift
//  StepViewExample
//
//  Created by Vlados iOS on 12/17/18.
//  Copyright © 2018 VladislavShilov. All rights reserved.
//

import UIKit
import StepView

final class ContainerViewController: UIViewController {
    @IBOutlet private weak var stepView: StepView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextButton: UIButton!
    
    private var pageViewController: UIPageViewController!
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: String.init(describing: FirstViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: SecondViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: FirstViewController.self)),
            self.getViewController(withIdentifier: String.init(describing: SecondViewController.self))
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowBack"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backButtonDidPress))

        setupControllers()
    }
    
    // MARK: - Setup views
    
    private func setupControllers() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = containerView.bounds
        containerView.addSubview(pageViewController.view)
        
        if let firstController = pages.first {
            pageViewController.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    private func getControllerToShow(from index: Int) -> UIViewController? {
        if index - 1 < pages.count {
            return pages[index - 1]
        }
        else {
            print("Index is out of range")
            return nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonDidPress(_ sender: Any) {
        stepView.showNextStep()
        
        if let controllerToShow = getControllerToShow(from: stepView.selectedStep) {
            pageViewController.setViewControllers([controllerToShow], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @objc private func backButtonDidPress() {
        if stepView.selectedStep == 1 {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            stepView.showPreviousStep()
            
            if let controllerToShow = getControllerToShow(from: stepView.selectedStep) {
                pageViewController.setViewControllers([controllerToShow], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
}
