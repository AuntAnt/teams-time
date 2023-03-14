//
//  LoginViewController.swift
//  teams-time
//
//  Created by Админ on 12/03/2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var timeZonePicker: UIPickerView?
    @IBOutlet var loginButton: UIButton!
    
    let timezone = Timezone.allCases
    
    private var user: TeamMember!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeZonePicker?.dataSource = self
        timeZonePicker?.delegate = self
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    
        loginButton.layer.cornerRadius = 8
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? TabBarViewController else { return }
        guard let mainVC = tabBarVC.viewControllers?.first as? UserActivityViewController else { return }
        
        mainVC.user = user
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @IBAction func logInPressed() {
        guard let userName = userNameTextField.text else { return }
        let selectedTimezone = timezone[timeZonePicker?.selectedRow(inComponent: 0) ?? 0]
        
        user = TeamMember(name: userName, timezone: selectedTimezone, contact: nil)
        
        if userNameTextField.text == "" {
            showAlert(
                title: "Required field is empty",
                message: "Please, enter your name",
                textField: userNameTextField
            )
        } else {
            performSegue(withIdentifier: "openMainVC", sender: nil)
        }
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension LoginViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timezone.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timezone[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
