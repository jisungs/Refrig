//
//  AlertService.swift
//  Refrig
//
//  Created by The book on 15/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert() -> AlertViewController {
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        return alertVC
    }
}
