//
//  DamDetailViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/27.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DamDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var distPlaceLable: UILabel!
    @IBOutlet var distDateLabel: UILabel!
    
    var damId : Int?
    var damName : String?
    var distributionPlaceName : String?
    var distributionDate : String?
    var prefectureName : String?
    var address : String?
    var url : String?
        
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameLabel?.text = damName
        self.distPlaceLable?.text = distributionPlaceName
        self.distDateLabel?.text = distributionDate
        self.addressLabel?.text = address
        self.urlLabel?.text = url
        
        //初期位置を設定
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate,MKCoordinateSpanMake(0.003, 0.003))
        mapView.setRegion(centerPosition,animated:true)
        
        CLGeocoder().geocodeAddressString(self.address, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {println("reverse geodcode fail: \(error.localizedDescription)")}
            if placemarks.count > 0 {
                var placemark:CLPlacemark = placemarks[0] as CLPlacemark
                var coordinates:CLLocationCoordinate2D = placemark.location.coordinate
                
                var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
                pointAnnotation.title = self.damName as String!
                pointAnnotation.subtitle = self.address as String!
                self.mapView.addAnnotation(pointAnnotation)
                self.mapView.selectAnnotation(pointAnnotation, animated: true)

                self.mapView.centerCoordinate = coordinates
                println("Added annotation to map view")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "traditionToWriteCommentView" {
            var destViewController: DamCommentViewController = segue.destinationViewController as DamCommentViewController
            destViewController.damId = self.damId as Int!
        }
    }

}
