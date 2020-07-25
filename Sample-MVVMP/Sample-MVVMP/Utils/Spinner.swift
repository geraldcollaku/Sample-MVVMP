//
//  Spinner.swift
//  Sample-MVVMP
//
//  Created by Gerald Collaku on 25.07.20.
//

import UIKit

class Spinner {
    
    static var activityIndicator: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .large
    static var baseBackColor = UIColor.black
    static var baseColor = UIColor.white
    
    /**
     Add spinner to `UIView`
     - Parameters:
     - view: The `UIView` being used to add the `UIActivityIndicatorView` onto
     - style: Style used for the `UIActivityIndicatorView`
     - backgroundColor: Display color
     - baseColor: Tint color of the spinner
     */
    static func start(from view: UIView,
                      style: UIActivityIndicatorView.Style = Spinner.style,
                      backgroundColor: UIColor = Spinner.baseBackColor,
                      baseColor: UIColor = Spinner.baseColor) {
        
        guard Spinner.activityIndicator == nil else { return }
        
        let spinner = UIActivityIndicatorView(style: style)
        spinner.backgroundColor = backgroundColor
        spinner.color = baseColor
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        // Auto-layout constraints
        addConstraints(to: view, with: spinner)
        
        Spinner.activityIndicator = spinner
        Spinner.activityIndicator?.startAnimating()
    }
    
    /// Stops and removes `UIActivityIndicatorView`
    public static func stop() {
        Spinner.activityIndicator?.stopAnimating()
        Spinner.activityIndicator?.removeFromSuperview()
        Spinner.activityIndicator = nil
    }
    
    /**
     Add auto-layout constraints to provided `UIActivityIndicatorView`
     - Parameters:
     - view: The view used to provide layout constraints
     - spinner: The `UIActivityIndicatorView` used to display
     */
    fileprivate static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
