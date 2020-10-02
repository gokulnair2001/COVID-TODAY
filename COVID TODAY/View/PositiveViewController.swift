//
//  PositiveViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 29/09/20.
//

import UIKit

class PositiveViewController: UIViewController {
    let haptic = haptickFeedback()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func doneBtn(_ sender: Any) {
       // self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "hospitalise", sender: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
}
