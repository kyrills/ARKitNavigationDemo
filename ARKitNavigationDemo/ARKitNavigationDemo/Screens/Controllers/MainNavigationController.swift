//
//  TEstCoordinatorViewController.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .clear
        self.navigationBar.tintColor = .white
        self.navigationBar.backgroundColor = UIColor.clear

    }
}
