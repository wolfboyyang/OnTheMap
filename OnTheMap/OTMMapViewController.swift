//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Wei Yang on 6/30/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import MapKit

class OTMMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The "locations" array is an array of dictionary objects that are similar to the JSON
        // data that you can download from parse.
        //let locations = hardCodedLocationData()
        
        
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        OTMClient.sharedInstance().getStudentLocations { (results, error) in
            
            if let error = error {
                print(error)
                self.createAlertWithTitle("Downloading Failed", message: "Try again later.", actionMessage: "Ok", completionHandler: nil)
                
            } else {
                
                guard let results = results else {
                    print("No location data")
                    return
                }
                
                // We will create an MKPointAnnotation for each dictionary in "locations". The
                // point annotations will be stored in this array, and then provided to the map view.
                var annotations = [MKPointAnnotation]()
                
                for StudentLocation in results {
                    
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate = CLLocationCoordinate2D(latitude: StudentLocation.latitude, longitude: StudentLocation.longitude)
                    
                    // Here we create the annotation and set its coordiate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = StudentLocation.fullName
                    annotation.subtitle = StudentLocation.mediaURL
                    
                    // Finally we place the annotation in an array of annotations.
                    annotations.append(annotation)
                    
                    performUIUpdatesOnMain {
                        // When the array is complete, we add the annotations to the map.
                        self.mapView.addAnnotations(annotations)
                    }
                }
            }
        }
        
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            if let toOpen = view.annotation?.subtitle! {
                
                let app = UIApplication.sharedApplication()
                let url = NSURL(string: toOpen)!
                
                if app.canOpenURL(url) {
                    app.openURL(url)
                } else {
                    print("Invalid URL: \"\(url)\"")
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
