//
//  ProfileViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import UIKit
import MessageUI


class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
        
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addDetails: UIButton!
    
  
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var numberLbla: UILabel!
    
    
    let addDelegate = AddDetailsViewController()
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        
    }
    
    @IBAction func addDetails(_ sender: Any) {
        self.performSegue(withIdentifier: "adddetails", sender: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func mailBtn(_ sender: Any) {
        mailUS(reciptent: "ncov2019@gov.in", subject: "Hi Sir,")
        haptic.haptiFeedback1()
    }
    
    @IBAction func mailGovBtn(_ sender: Any) {
        mailUS(reciptent: "ncov2019@gov.in" , subject: "Hi Sir,")
        haptic.haptiFeedback1()
    }
    
   
}


//MARK:- Helpline Number
extension ProfileViewController{
    @IBAction func helpLineCall(_ sender: Any) {
        if let phoneUrl = URL(string: "tel://1123978046"){
            if UIApplication.shared.canOpenURL(phoneUrl){
                UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
            }else{
                let alertController = UIAlertController(title: nil, message: "Your Device don't support Call", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
        }
        haptic.haptiFeedback1()
    }
    
}


//MARK:- mail method

extension ProfileViewController{
    
    func mailUS(reciptent: String, subject: String) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([reciptent])
        composer.setSubject(subject)
        composer.setMessageBody("Hi,Respected sir.", isHTML: false)
        
        present(composer, animated: true)
    }
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        @unknown default:
            print("other error")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

