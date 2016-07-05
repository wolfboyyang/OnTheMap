//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Wei Yang on 7/5/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class OTMTableViewController: UITableViewController {
    
    var StudentLocations: [StudentLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Table View Loaded")
        if OTMClient.sharedInstance().studentLocations != nil {
            self.StudentLocations = OTMClient.sharedInstance().studentLocations
        } else {
            print("no data")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("StudentLocations:\(StudentLocations?.count)")
        return StudentLocations?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationCell")
        
        let studentLocation = StudentLocations![indexPath.row]
        cell?.textLabel?.text = studentLocation.fullName
        cell?.detailTextLabel?.text = studentLocation.mediaURL
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let url = NSURL(string: StudentLocations![indexPath.row].mediaURL)!
        let app = UIApplication.sharedApplication()
        if app.canOpenURL(url) {
            app.openURL(url)
        } else {
            print("Invalid URL: \(url)")
        }
    }
    
}
