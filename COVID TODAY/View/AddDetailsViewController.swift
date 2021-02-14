//
//  AddDetailsViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController {
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextield: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

//MARK:- Add Btn Methods

extension AddDetailsViewController {
    
    @IBAction func addBtn(_ sender: Any) {
       
    }
}

