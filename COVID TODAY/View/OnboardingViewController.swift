//
//  OnboardingViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 02/10/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        okButton.layer.shadowOpacity = 0.7
        okButton.layer.shadowOffset = .zero
        okButton.layer.shadowRadius = 3
        okButton.layer.cornerRadius = 10
       
    }
    

    @IBAction func OKBtn(_ sender: Any) {
        self.dismiss(animated:true)
        core.shared.setIsNotNewUser()
    }
    
}
