//
//  TEstCoordinatorViewController.swift
//  ARKitNavigationDemo
//
//  Created by Ben Smith on 17/11/2017.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

class TestCoordinatorViewController: UIViewController {
    
//    var whenToBoService = SchipholWhenToBeService()
    
    @IBOutlet weak var flightNumberoutlet: UITextField!
 
    @IBOutlet var addItemView : UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var flightNumberLabel: UILabel!
    
    @IBOutlet var contentContainer: UIStackView!
    var progressView: UIProgressView?
    var progressLabel: UILabel?
    var effect: UIVisualEffect!
    var timer: Timer!
    let rect = CGRect(
        origin: CGPoint(x: -25, y: -100),
        size: UIScreen.main.bounds.size
    )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        setupTextField()
    }
    
    
    override func viewDidAppear(_ _animated: Bool) {
        super.viewDidAppear(_animated)
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        addItemView.layer.cornerRadius = 5
        self.animeteBlurIn()
        self.visualEffectView.isHidden = false
        
    }
    @IBAction func startAR(_ sender: Any) {
        print("start AR")
    }
    @IBAction func didPressFlight(_ sender: Any) {
        if let isFlightNumber = flightNumberoutlet.text {
            SchipholWhenToBeService.checkWhentoBeAtSChiphol(flightNumber: isFlightNumber, onCompletion: { (success, rectTime) in
                if success {
                    if let time = rectTime {

                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = formatter.date(from: time) {
                            
                            self.timeLabel.text = self.printTimestamp(date: date)
                        }
                    }
                    
                } else {
                    print("f*k something went wrong")
                }
            })
            
            animateBlurout()
            self.visualEffectView.isHidden = true
            
        }
    }
    
    func printTimestamp(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    
    @IBAction func didPressChangeFlight(_ sender: Any) {
        animeteBlurIn()
        flightNumberoutlet.becomeFirstResponder()
        self.visualEffectView.isHidden = false
    }
    
    func animeteBlurIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateBlurout() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) { (succes:Bool) in
            self.addItemView.removeFromSuperview()
        }
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


// MARK: - INPUT
extension TestCoordinatorViewController: UITextFieldDelegate {
    
    func setupTextField() {
        flightNumberoutlet.delegate = self
     }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        flightNumberoutlet.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let flightNumber = flightNumberoutlet {
            flightNumberLabel.text = flightNumber.text
        }
    }
}


// MARK: - data
extension TestCoordinatorViewController {
    
}
