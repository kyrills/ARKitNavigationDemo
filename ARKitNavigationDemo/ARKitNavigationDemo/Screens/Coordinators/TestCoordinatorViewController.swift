//
//  TEstCoordinatorViewController.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

class TestCoordinatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - View setup
extension TestCoordinatorViewController {
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Color.blue3.cgColor, Color.blue2.cgColor, Color.blue1.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
