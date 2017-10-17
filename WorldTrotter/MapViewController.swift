//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 杨佩璋 on 2017/10/15.
//  Copyright © 2017年 杨佩璋. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mkView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController is loaded")
    }
    
    override func loadView() {
        mkView = MKMapView()
        view = mkView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard Map")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid Map")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite Map")
        let segmentControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        view.addSubview(segmentControl)
        
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0)
        let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingContraint = segmentControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingContraint.isActive = true
        segmentControl.addTarget(self, action: #selector(MapViewController.segmentControlIndexChange(_:)), for: .valueChanged)
    }
    
    @objc func segmentControlIndexChange(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mkView.mapType = .standard
        case 1:
            mkView.mapType = .hybrid
        case 2:
            mkView.mapType = .satellite
        default:
            break
        }
    }

}



