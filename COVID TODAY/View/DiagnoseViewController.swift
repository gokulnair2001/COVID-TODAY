//
//  DiagnoseViewController.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 29/09/20.
//

import UIKit
import CoreML

class DiagnoseViewController: UIViewController {

    @IBOutlet weak var xrayImage: UIImageView!
    @IBOutlet weak var imagelabel: UILabel!
    
    let covidDetector = COVIDDetector()
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //xrayImage.layer.borderWidth = 1
       // xrayImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @IBAction func addXRay(_ sender: Any) {
        imageSelectionMode()
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func examineBtn(_ sender: Any) {
        imageClassifier()
        haptic.haptiFeedback1()
    }
}


//MARK:- MLModel Methods

extension DiagnoseViewController{
    
    func imageClassifier(){
        
        var inputImage = [COVIDDetectorInput]()
        
        if let image = xrayImage.image{
           let newImage =  buffer(from: xrayImage.image!)
            let imageForClassification = COVIDDetectorInput(image: newImage!)
            inputImage.append(imageForClassification)
        }
        
        do {
            let prediction = try self.covidDetector.predictions(inputs: inputImage)
            
            for result in prediction{
                let res = result.classLabel
                
                if res == "NORMAL"{
                    self.performSegue(withIdentifier: "positive", sender: nil)
                }
                else if res == "COVID"{
                    self.performSegue(withIdentifier: "negative", sender: nil)
                }
                else{
                    imagelabel.isHidden = false
                    imagelabel.text = "Wrong image"
                }
            }
            
        }catch{
            print("error found\(error)")
        }
    }
}



//MARK:- IMAGE SELECTION METHOD

extension DiagnoseViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.xrayImage.image = image
       self.imagelabel.isHidden = true
    }
    
    func setupImageSelection(action: UIAlertAction){
        
        if action.title == "Camera" {
            UIImagePickerController.isSourceTypeAvailable(.camera)
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        else if action.title == "Gallery"{
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        else{
            print("None of the above")
        }
        
    }
    
}


//MARK:- ALERT CONTROLER METHOD FOR IMAGE SELECTION
extension DiagnoseViewController {
    func imageSelectionMode(){

      let alert = UIAlertController(title: "Select Mode", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: setupImageSelection))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:setupImageSelection))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
        
    }
    
}


//MARK:- To convert uiimage to cvpixelbuffer

extension DiagnoseViewController{
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
}
