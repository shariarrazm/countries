//
//  DetailController.swift
//  Countries
//
//  Created by Shariar Razm1 on 2017-10-24.
//  Copyright © 2017 Shariar Razm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftSVG

class DetailController: UIViewController {
	
	var country: Country? = nil

    let detailContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let translationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "translation"
        return label
    }()
    
    let languageSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "language"
        return label
    }()
    
    let capitalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "capital"
        return label
    }()
    
    let regionSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "region"
        return label
    }()
    
    let nativeSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nativeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Antive name"
        return label
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "contry name"
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 8
        mapView.layer.masksToBounds = true
        mapView.isZoomEnabled = false
        return mapView
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = country?.name
        view.addSubview(containerView)
        view.addSubview(detailContainerView)
        
		if let latitude = country?.latlng[0], let longitude = country?.latlng[1] {
			let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
			let span = MKCoordinateSpanMake(12, 12)
			let region = MKCoordinateRegion(center: location, span: span)
			locationView.setRegion(region, animated: true)
        
			let annotaion = MKPointAnnotation()
			annotaion.coordinate = location
			annotaion.title = country?.name
			locationView.addAnnotation(annotaion)
		}

		setupImage()
        
        countryName.text = "Name: " + (country?.name)!
        nativeNameLabel.text = "Native name: " + (country?.nativeName)!
        regionLabel.text = "Region: " + (country?.region)!
        capitalLabel.text = "Capital: " + (country?.capital)!
        translationLabel.text = "Translations: " + (country?.translations.de)!
		
		if let languages = country?.languages.map({$0.name}).joined(separator: ",") {
			languageLabel.text = "Languages: \(languages)"
		}
		
        setupContainerView()
        setupConstraints()
        setupDetailConstraints()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupImage(){
        if let flagImageUrl = country?.flag {
            flagImageView.loadImageUrlString(urlString: flagImageUrl)
        }
    }
    
    func setupContainerView() {
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -8).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        containerView.addSubview(flagImageView)
        containerView.addSubview(locationView)
        
        detailContainerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 18).isActive = true
        detailContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        detailContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        detailContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        
    }
    
    func setupConstraints() {
        
        
        flagImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4).isActive = true
        flagImageView.rightAnchor.constraint(equalTo: locationView.leftAnchor, constant: -5).isActive = true
        flagImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        flagImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2).isActive = true

        locationView.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: -6).isActive = true
        locationView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -6).isActive = true
        locationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        locationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        locationView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2).isActive = true
        
        
    }
    
    func setupDetailConstraints() {
        
        detailContainerView.addSubview(countryName)
        detailContainerView.addSubview(nameSeparatorView)
        detailContainerView.addSubview(nativeNameLabel)
        detailContainerView.addSubview(nativeSeparatorView)
        detailContainerView.addSubview(regionLabel)
        detailContainerView.addSubview(regionSeparatorView)
        detailContainerView.addSubview(capitalLabel)
        detailContainerView.addSubview(capitalSeparatorView)
        detailContainerView.addSubview(languageLabel)
        detailContainerView.addSubview(languageSeparatorView)
        detailContainerView.addSubview(translationLabel)
        
        countryName.topAnchor.constraint(equalTo: detailContainerView.topAnchor, constant: 8).isActive = true
        countryName.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        countryName.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        countryName.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: countryName.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        nativeNameLabel.topAnchor.constraint(equalTo: countryName.bottomAnchor).isActive = true
        nativeNameLabel.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        nativeNameLabel.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        nativeNameLabel.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
        nativeSeparatorView.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor).isActive = true
        nativeSeparatorView.topAnchor.constraint(equalTo: nativeNameLabel.bottomAnchor).isActive = true
        nativeSeparatorView.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor).isActive = true
        nativeSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        regionLabel.topAnchor.constraint(equalTo: nativeSeparatorView.bottomAnchor).isActive = true
        regionLabel.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        regionLabel.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        regionLabel.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
        regionSeparatorView.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor).isActive = true
        regionSeparatorView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor).isActive = true
        regionSeparatorView.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor).isActive = true
        regionSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        capitalLabel.topAnchor.constraint(equalTo: regionSeparatorView.bottomAnchor).isActive = true
        capitalLabel.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        capitalLabel.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        capitalLabel.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
        capitalSeparatorView.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor).isActive = true
        capitalSeparatorView.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor).isActive = true
        capitalSeparatorView.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor).isActive = true
        capitalSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        languageLabel.topAnchor.constraint(equalTo: capitalSeparatorView.bottomAnchor).isActive = true
        languageLabel.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        languageLabel.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        languageLabel.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
        languageSeparatorView.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor).isActive = true
        languageSeparatorView.topAnchor.constraint(equalTo: languageLabel.bottomAnchor).isActive = true
        languageSeparatorView.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor).isActive = true
        languageSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        translationLabel.topAnchor.constraint(equalTo: languageSeparatorView.bottomAnchor).isActive = true
        translationLabel.leftAnchor.constraint(equalTo: detailContainerView.leftAnchor, constant: 8).isActive = true
        translationLabel.rightAnchor.constraint(equalTo: detailContainerView.rightAnchor).isActive = true
        translationLabel.heightAnchor.constraint(equalTo: detailContainerView.heightAnchor, multiplier: 1/6).isActive = true
        
    }
}

extension UIImageView {
    func loadImageUrlString(urlString: String) {
        if urlString.hasSuffix(".svg") {
            let svgURL = URL(string: urlString)!
            let _ = UIView(SVGURL: svgURL) { (svgLayer) in
                svgLayer.resizeToFit(self.bounds)
                //svgLayer.resizeToFit(CGRect(x: 0, y: 0, width: 200, height: 200))
                self.layer.addSublayer(svgLayer)
            }
        } else {
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.image = image
                }
            }.resume()
        }
    }
}
