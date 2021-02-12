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
    
    var dataFetched:Bool = false
    
    var fTotalDeaths:[Double] = [0.0]
    var fNewConfirmed:[Double] = [0.0]
    var fTotalConfirmed:[Double] = [0.0]
    var fNewDeath:[Double] = [0.0]
    var fNewRecovered:[Double] = [0.0]
    var fTotalRecovered:[Double] = [0.0]
    var fDate:[String] = [""]
    
    let mapCoordinates = coordinates()
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            present(vc, animated: true)
        }
        
        
        get()
        
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
        get()
        haptic.haptiFeedback1()
    }
    
}

//MARK:- UI Method

extension MainViewController
{
    func buttonAnimation(button: UIButton){
        UIView.animate(withDuration: 0.6,
                       animations: { button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6) },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {button.transform = CGAffineTransform.identity
                        }
                       })
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

//MARK:- GET DATA METHOD

extension MainViewController{
    func get(){
        let request = URLRequest(url: URL(string: "https://api.covid19api.com/summary")!,timeoutInterval: Double.infinity)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                
                return
            }
            
            if let response = response as? HTTPURLResponse{
                guard (200 ... 299) ~= response.statusCode else {
                    print("Status code :- \(response.statusCode)")
                    
                    if response.statusCode == 400 {
                        DispatchQueue.main.async {
                            self.extraTrial()
                        }
                    }else if response.statusCode == 401{
                        DispatchQueue.main.async {
                            self.alertView()
                        }
                    }else if response.statusCode == 403{
                        DispatchQueue.main.async {
                            self.serverError()
                        }
                        
                    }else if response.statusCode == 503{
                        DispatchQueue.main.async {
                            self.serverError()
                        }
                    }
                    return
                }
            }
            
            self.fTotalRecovered.removeAll()
            self.fTotalConfirmed.removeAll()
            self.fTotalDeaths.removeAll()
            self.fNewDeath.removeAll()
            self.fNewRecovered.removeAll()
            self.fNewConfirmed.removeAll()
            self.fDate.removeAll()
            
            do{
                if error == nil{
                    let result = try JSONDecoder().decode(coronaData.self, from: data)
                    
                    self.fNewConfirmed.append(result.Global.NewConfirmed)
                    self.fNewRecovered.append(result.Global.NewRecovered)
                    self.fNewDeath.append(result.Global.NewDeaths)
                    self.fTotalDeaths.append(result.Global.TotalDeaths)
                    self.fTotalConfirmed.append(result.Global.TotalConfirmed)
                    self.fTotalRecovered.append(result.Global.TotalRecovered)
                    self.fDate.append(result.Date)
                    self.dataFetched = true
                }
                
                DispatchQueue.main.async {
                    self.updateUI()
                }
                
            }catch{
                print("Error found")
            }
        }
        task.resume()
        
    }
}

// UI UPDATION METHOD

extension MainViewController{
    
    @objc func updateUI(){
        if (dataFetched){
    
        self.totalDeathLbl.text = String(Int(fTotalDeaths[0]))
        self.newDeaths.text = String(Int(fNewDeath[0]))

        self.totalCases.text = String(Int(fTotalConfirmed[0]))
        self.newCases.text = String(Int(fNewConfirmed[0]))

        self.totalRecovery.text = String(Int(fTotalRecovered[0]))
        self.newRecovery.text = String(Int(fNewRecovered[0]))
        self.date.text = String(fDate[0])
        
        }
    }
    
    func alertView() {
        let alert = UIAlertController(title: "Error", message: "close the app!(Open again and Login)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    func extraTrial() {
        let alert = UIAlertController(title: "Error", message: "Only one attempt possible", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func serverError() {
        let alert = UIAlertController(title: "Server Error", message: "close the app!(Open again and Login)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
