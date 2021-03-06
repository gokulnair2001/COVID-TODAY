//
//  stepsViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 01/10/20.
//

import UIKit

class stepsViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyShadow(yourView: view1)
        applyShadow(yourView: view2)
        applyShadow(yourView: view3)
        applyShadow(yourView: view4)
        applyShadow(yourView: view5)
        applyShadow(yourView: view6)
     
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
  

}

//MARK:- UIView shadow effect

extension stepsViewController{
    func applyShadow(yourView: UIView){
        yourView.layer.shadowColor = UIColor.black.cgColor
        yourView.layer.shadowOpacity = 1
        yourView.layer.shadowOffset = .zero
        yourView.layer.shadowRadius = 4
        yourView.layer.cornerRadius = 10
    }
}
