//
//  CommonClass.swift
//  SyncracyTest
//
//  Created by Anil on 04/04/21.
//

import Foundation
import UIKit

class CommonClass {
    static let shared = CommonClass()
    typealias responseHandler = (_ response:String) ->()
    func methodForShow(vc : UIViewController, handler : @escaping(responseHandler)){
        let alert = UIAlertController(
            title: "Language Change".localized,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        func addActionLanguage(language: String) {
            alert.addAction(
                UIAlertAction(
                    title: language,
                    style: UIAlertAction.Style.default,
                    handler: { _ in
                        if language == "English"{
                            Language.language = Language.english
                            handler(Language.english.rawValue)
                        }else if language == "Arabic"{
                            Language.language = Language.arabic
                            handler(Language.arabic.rawValue)
                        }
                })
            )
        }
        
        addActionLanguage(language: "English")
        addActionLanguage(language: "Arabic")
        
        alert.addAction(
            UIAlertAction(
                title: "cancel".localized,
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        vc.present(alert, animated: true, completion: nil)
    }
 
}

final class Spinner {

private static var activityIndicator: UIActivityIndicatorView?
private static var style: UIActivityIndicatorView.Style = .medium
private static var baseBackColor = UIColor(white: 0, alpha: 0.6)
private static var baseColor = UIColor.white

public static func start(from view: UIView,
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
private static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
    spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
}
}
