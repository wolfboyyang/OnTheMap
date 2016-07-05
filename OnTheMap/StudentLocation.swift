//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Wei Yang on 6/30/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

struct StudentLocation {
    
    // MARK: Properties
    
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // MARK: Initializers
    
    // construct a StudentLocation from a dictionary
    init(dictionary: [String:AnyObject]) {
        createdAt = dictionary[OTMClient.JSONResponseKeys.CreatedAt] as! String
        firstName = dictionary[OTMClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[OTMClient.JSONResponseKeys.LastName] as! String
        latitude = dictionary[OTMClient.JSONResponseKeys.Latitude] as! Double
        longitude = dictionary[OTMClient.JSONResponseKeys.Longitude] as! Double
        mapString = dictionary[OTMClient.JSONResponseKeys.MapString] as! String
        mediaURL = dictionary[OTMClient.JSONResponseKeys.MediaURL] as! String
        objectId = dictionary[OTMClient.JSONResponseKeys.ObjectID] as! String
        uniqueKey = dictionary[OTMClient.JSONResponseKeys.UniqueKey] as! String
        updatedAt = dictionary[OTMClient.JSONResponseKeys.UpdatedAt] as! String
    }
    
    static func studentLocationsFromResults(results: [[String:AnyObject]]) -> [StudentLocation] {
        
        var locations = [StudentLocation]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            locations.append(StudentLocation(dictionary: result))
        }
        
        return locations
    }
}
