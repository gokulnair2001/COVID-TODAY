//
//  HelpViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import UIKit

class HelpViewController: UIViewController {
    
    let haptic = haptickFeedback()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func symptoms(_ sender: Any) {
        self.performSegue(withIdentifier: "symptoms", sender: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func dodont(_ sender: Any) {
        self.performSegue(withIdentifier: "steps", sender: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func virus(_ sender: Any) {
        haptic.haptiFeedback1()
        uialertContol()
        
    }

    @IBAction func myths(_ sender: Any) {
        uialertContol()
        haptic.haptiFeedback1()
    }
    
    @IBAction func harm(_ sender: Any) {
        uialertContol()
        haptic.haptiFeedback1()
    }
    @IBAction func government(_ sender: Any) {
        uialertContol()
        haptic.haptiFeedback1()
    }
}


//MARK:- UIAlert controller function

extension HelpViewController{
    func uialertContol(){
        let alert = UIAlertController(title: "Error", message: "Currently not available", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
