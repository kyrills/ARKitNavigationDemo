//
//  MainNavigationController.swift
//  ARKitNavigationDemo
//
//  Created by Ivo Nederlof on 17-11-17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.tintColor = .white
        self.navigationBar.isTranslucent = true
    }

}
