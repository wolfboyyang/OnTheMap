//
//  OnTheMapConstants.swift
//  OnTheMap
//
//  Created by Wei Yang on 6/30/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation

extension OTMClient {
    
    // MARK: - Constants
    
    struct Constants {
        
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseRestAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: URLs
        static let ParseApiScheme = "https"
        static let ParseApiHost = "api.parse.com"
        static let ParseApiPath = "/1/classes"
    }
    
    struct Methods {
        // Mark: Udacity
        static let UdacitySession = "https://www.udacity.com/api/session"
        static let UdacityPublicUserData = "https://www.udacity.com/api/users/<user_id>"
        
        // Mark: Parse
        static let StudentLocation = "/StudentLocation"
        static let PutStudentLocation = "https://api.parse.com/1/classes/StudentLocation/<objectId>"
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "<user_id>"
        static let ObjectID = "<objectId>"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
    }
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        
        // MARK: Authorization
        static let Account = "account"
        static let Session = "session"
        
        // MARK: Account
        static let UserID = "key"
        
        // MARK: Results
        static let Results = "results"
        
        // MARK: StudentLocation
        static let CreatedAt = "createdAt"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let UpdatedAt = "updatedAt"
    }
}