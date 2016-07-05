//
//  OTMTabBarController.swift
//  OnTheMap
//
//  Created by Wei Yang on 7/5/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class OTMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let toolbar = UIToolbar()
//        let logout = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(OTMTabBarController.logout))
//        toolbar.items?.append(logout)
        
    }
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        print("Logout")
        OTMClient.sharedInstance().deleteUdacitySession()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        
        OTMClient.sharedInstance().getStudentLocations { (results, error) in
            
            if let error = error {
                print(error)
                self.createAlertWithTitle("Downloading Failed", message: "Try again later.", actionMessage: "Ok", completionHandler: nil)
                
            } else {
                
                guard let results = results else {
                    print("No location data")
                    return
                }
            }
        }
    }
    
    // MARK: Alert
    
    func createAlertWithTitle(title: String, message: String, actionMessage: String? = nil, completionHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        if let actionMessage = actionMessage {
            let action = UIAlertAction(title: actionMessage, style: .Default, handler: completionHandler)
            alert.addAction(action)
        }
        presentViewController(alert, animated: true, completion: nil)
    }
}
