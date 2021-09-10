//
//  ViewController.swift
//  Project16
//
//  Created by Alejandro Gleason on 09/09/21.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", wikiPage: URL(string: "https://es.wikipedia.org/wiki/Londres")!)
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", wikiPage: URL(string: "https://es.wikipedia.org/wiki/Oslo")!)
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", wikiPage: URL(string: "https://es.wikipedia.org/wiki/Par%C3%ADs")!)
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", wikiPage: URL(string: "https://es.wikipedia.org/wiki/Roma")!)
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", wikiPage: URL(string: "https://es.wikipedia.org/wiki/Washington_D._C.")!)
        
        // Adding the pins to the map
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        let ac = UIAlertController(title: "Map View", message: "Please choose desired map view style", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapView))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: setMapView))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapView))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapView))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.present(ac, animated: true)
        }
    }
    
    func setMapView(action: UIAlertAction){
        guard let actionTitle = action.title else { return }
        
        switch actionTitle {
        case "Standard":
            mapView.mapType = .standard
            break
        case "Muted Standard":
            mapView.mapType = .mutedStandard
            break
        case "Hybrid":
            mapView.mapType = .hybrid
            break
        case "Satellite":
            mapView.mapType = .satellite
            break
        default:
            break
        }
    }

    // Method called each time map needs to show an annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.purple
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
            annotationView?.pinTintColor = UIColor.purple
        }
        
        return annotationView
    }
    
    // This function gets triggered each time an anotation view's button is called
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeSite = capital.wikiPage
        
        let vc = DetailViewController()
        vc.title = placeName
        vc.wikiUrl = placeSite
        navigationController?.pushViewController(vc, animated: true)
        
        // let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        // ac.addAction(UIAlertAction(title: "OK", style: .default))
        // present(ac, animated: true)
        
    }
    
}

