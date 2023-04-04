//
//  UIViewController+Extension.swift
//  teams-time
//
//  Created by Anton Kuzmin on 18.03.2023.
//

import UIKit

//MARK: - Alert extension
extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
