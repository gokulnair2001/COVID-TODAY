//
//  NegativeViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 29/09/20.
//

import UIKit

class NegativeViewController: UIViewController {

    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OKBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
}
