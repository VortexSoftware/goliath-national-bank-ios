//
//  LoadingView.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

public class LoadingOverlay {

    static var overlayBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
    static var activityIndicatorStyle = UIActivityIndicatorView.Style.gray
    
    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    public func show(over view: UIView!){
        hide()
        
        overlayView = UIView()
        overlayView.backgroundColor = LoadingOverlay.overlayBackgroundColor
        
        activityIndicator = UIActivityIndicatorView(style: LoadingOverlay.activityIndicatorStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addConstraint(overlayView.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor))
        overlayView.addConstraint(overlayView.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor))
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        view.addEmbedded(view: overlayView)
    }
    
    public func hide(){
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
