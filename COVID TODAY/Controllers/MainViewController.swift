//
//  ViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 29/09/20.
//

import UIKit
import MapKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var examineButton: UIButton!
    @IBOutlet weak var HospitalseButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var totalDeathLbl: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    
    @IBOutlet weak var newCases: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    
    @IBOutlet weak var totalRecovery: UILabel!
    @IBOutlet weak var newRecovery: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let haptic = haptickFeedback()
    
    let mapCoordinates = coordinates()
    
    var manager = caseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            present(vc, animated: true)
        }
        
        manager.delegate = self //never forget this line....very imp
        
        mapView.overrideUserInterfaceStyle = .light
        mapView.layer.cornerRadius = 20
        mapView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        mapView.layer.borderWidth = 1
        
        applyShadow(yourView: view1)
        applyShadow(yourView: view2)
        applyShadow(yourView: view3)
        applyShadow(yourView: view4)
        applyShadow(yourView: view5)
        applyShadow(yourView: view6)
        
        mapMarker(locations: mapCoordinates.annotations)
        manager.performURL()
        
    }
    @IBAction func profileBtn(_ sender: Any) {
        buttonAnimation(button: profileButton)
        performSegue(withIdentifier: "Profile", sender: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func examineBtn(_ sender: Any) {
        buttonAnimation(button: examineButton)
        performSegue(withIdentifier: "Diagnose", sender: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func HospitaliseBtn(_ sender: Any) {
        buttonAnimation(button: HospitalseButton)
        performSegue(withIdentifier: "Hospitalise", sender: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func helpBtn(_ sender: Any) {
        buttonAnimation(button: helpButton)
        performSegue(withIdentifier: "Help", sender: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func relodeDataBtn(_ sender: Any) {
        manager.performURL()
        haptic.haptiFeedback1()
    }
    
}

//MARK:- UI Method

extension MainViewController
{
    func buttonAnimation(button: UIButton){
        UIView.animate(withDuration: 0.6,
                       animations: { button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {button.transform = CGAffineTransform.identity
                        }
                       })
    }
}


//MARK:- API calls

extension MainViewController: CoronaCaseManagerDelegate{
    
    func didUpdateStats(_ caseManager: caseManager, stats: caseModel) {
        
        DispatchQueue.main.async {
            
            self.totalDeathLbl.text = String(stats.tDeaths)
            self.newDeaths.text = String(stats.nDeaths)
            
            self.totalCases.text = String(stats.tCase)
            self.newCases.text = String(stats.nCase)
            
            self.totalRecovery.text = String(stats.tRecovery)
            self.newRecovery.text = String(stats.nRecovery)
            
            self.date.text = stats.time
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        let alertControl = UIAlertController(title:"Error", message: "Enter Correct Place", preferredStyle: .actionSheet)
        alertControl.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertControl, animated: true,completion: nil)
    }
    
    
}

//MARK:- UIView shadow effect

extension MainViewController{
    func applyShadow(yourView: UIView){
        yourView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        yourView.layer.shadowOpacity = 0.7
        yourView.layer.shadowOffset = .zero
        yourView.layer.shadowRadius = 3
        yourView.layer.cornerRadius = 10
    }
}

//MARK:- mapview settings
extension MainViewController{
    func mapMarker(locations: [[String:Any]]){
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
           mapView.addAnnotation(annotation)
            
            
        }
    }
}


//MARK:-  Onboarding Code

class core{
    
    static let shared = core()
    
    func isNewUser()->Bool {
        return !UserDefaults.standard.bool(forKey: "onboarding")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "onboarding")
    }
}


