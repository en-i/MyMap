//
//  MapView.swift
//  MyMap
//
//  Created by terada enishi on 2021/07/09.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let searchKey: String
    
    let mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKey, completionHandler: {(placemarks,error) in
            if let unwrapPlacemarks = placemarks,
               let firstPlacemarks = unwrapPlacemarks.first,
               let location = firstPlacemarks.location{
                let targetCordinate = location.coordinate
                
                let pin = MKPointAnnotation()
                
                pin.coordinate = targetCordinate
                
                pin.title = searchKey
                
                uiView.addAnnotation(pin)
                
                uiView.region = MKCoordinateRegion(
                    center: targetCordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0)
            }
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー", mapType: .standard)
    }
}
