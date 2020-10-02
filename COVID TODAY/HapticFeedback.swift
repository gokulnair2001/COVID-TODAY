//
//  HapticFeedback.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 02/10/20.
//

import Foundation
import AVKit

class haptickFeedback {

    func haptiFeedback1() {
  //print("haptick done")
  let generator = UINotificationFeedbackGenerator()
  generator.notificationOccurred(.success)
  }
  
 func haptiFeedback2() {
  //print("haptick done")
  let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.warning)
  }
}

