//
//  HospitalViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 03/01/21.
//

import UIKit

class HospitalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        alert()
    }
    

    func alert() {
        let alert = UIAlertController(title: "Coming Soon", message: "Work under process!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
            self.closeSB()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func closeSB(){
        self.dismiss(animated: true, completion: nil)
    }
}
