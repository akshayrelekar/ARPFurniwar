//
//  ViewController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 11/30/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var companyName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "LoginPageBackGround.jpg")!)
        //LogIn Button customization
        logInButton.layer.borderColor = UIColor.black.cgColor
        logInButton.layer.borderWidth = 1
        logInButton.layer.cornerRadius = 15
        logInButton.alpha = 0
        
        
        //Sign Up Button customization
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 15
        signUpButton.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.logInButton.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            self.signUpButton.alpha = 1.0
        }, completion: nil)
    }

}

