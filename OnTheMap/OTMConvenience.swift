//
//  OnTheMapConvenience.swift
//  OnTheMap
//
//  Created by Wei Yang on 6/30/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import Foundation

extension OTMClient {
    
    func postUdacitySession(username username: String, password: String, completionHandlerForSession: (result: String?, error: NSError?) -> Void) {
        
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        taskForPOSTMethod(Methods.UdacitySession, jsonBody: jsonBody, dataStart: 5) { (results, error) in
            if let error = error { // Handle error…
                completionHandlerForSession(result: nil, error: error)
                return
            } else {
                
                func sendError(error: String) {
                    print(error)
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandlerForSession(result: nil, error: NSError(domain: "postUdacitySession", code: 1, userInfo: userInfo))
                }
                
                guard let account = results[JSONResponseKeys.Account] as? [String: AnyObject] else {
                    sendError("No account Data")
                    return
                }
                
                guard let userID = account[JSONResponseKeys.UserID] as? String else {
                    sendError("No userID")
                    return
                }
                
                self.userID = userID
                completionHandlerForSession(result: userID, error: nil)
            }
        }
    }
    
    func deleteUdacitySession() {
        let request = NSMutableURLRequest(URL: NSURL(string: Methods.UdacitySession)!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            print(xsrfCookie.value)
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                print(error)
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))

            // log out
            self.userID = nil
            self.studentLocations = nil
        }
        task.resume()
    }
    
    func getPublicUserData() {
        var mutableMethod: String = Methods.UdacityPublicUserData
        mutableMethod = subtituteKeyInMethod(mutableMethod, key: userID!, value: URLKeys.UserID)!
        let request = NSMutableURLRequest(URL: NSURL(string: mutableMethod)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
    
    func getStudentLocations(completionHandlerForStudentLocations: (result: [StudentLocation]?, error: NSError?) -> Void) {
        print("getStudentLocations")
        let parameters = [ParameterKeys.Limit: 100, ParameterKeys.Order:"-updatedAt"]
        taskForParseGETMethod(Methods.StudentLocation, parameters: parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocations(result: nil, error: error)
            } else {
                
                func sendError(error: String) {
                    print(error)
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandlerForStudentLocations(result: nil, error: NSError(domain: "getStudentLocations", code: 1, userInfo: userInfo))
                }
                
                guard let results = results[JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                    sendError("No Locations")
                    return
                }
                
                let locations = StudentLocation.studentLocationsFromResults(results)
                self.studentLocations = locations
                print("set information.")
                completionHandlerForStudentLocations(result: locations, error: nil)
                
            }
            
        }
    }
}