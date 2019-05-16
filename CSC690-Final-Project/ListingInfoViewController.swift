//
//  ViewController.swift
//  CSC690-Final-Project
//
//  Created by Alex Sergeev on 5/5/19.
//  Copyright © 2019 Alex Sergeev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ListingInfoViewController: UIViewController {
    
    var listing: Listing?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var housingType: UILabel!
    @IBOutlet weak var roomsBathsInfo: UILabel!
    
    // Buttton
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var showOnMapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setBtnStyles(button: self.contactBtn)
//        self.setBtnStyles(button: self.showOnMapBtn)
        // Do any additional setup after loading the view.
        if let listing = listing {
            housingType.text = listing.housingType
            price?.text = "$\(String(listing.price))"
            roomsBathsInfo?.text = "\(listing.bedrooms!) bds | \(listing.bathrooms!) ba"
            address?.text = "\(listing.line1!) \n \(listing.city!) \(listing.state!) \(listing.zipCode!)"
            image.image = UIImage(data: Data(base64Encoded: listing.images[0], options: .ignoreUnknownCharacters)!)
        }
    }
    
    private func setBtnStyles(button: UIButton!){
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func onContactPress(_ sender: UIButton) {
        guard let number = URL(string: "tel://+1 111 111 1111") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInModal = presentingViewController is UINavigationController
        if isPresentingInModal {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The ListingInfoViewController is not inside a navigation controller.")
        }
    }
    
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    @IBAction func showOnMap(_ sender: UIButton) {
        coordinates(forAddress: self.address?.text ?? "") {
            (location) in
            guard let location = location else {
                // Handle error here.
                return
            }
            self.openMapForPlace(lat: location.latitude, long: location.longitude, placeName: "Listing Address")
        }
    }
    
    public func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
//        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps()
    }
}

