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
        
        loginButton.layer.cornerRadius = 10
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? TabBarViewController else { return }
        guard let viewControllers = tabBarVC.viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationVC = viewController as? UINavigationController {
                guard let userVC = navigationVC.topViewController as? UserActivityViewController else {
                    return
                }
                userVC.user = user
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func logInPressed() {
        guard let userName = userNameTextField.text else { return }
        let selectedTimezone = timezone[timeZonePicker?.selectedRow(inComponent: 0) ?? 0]
        
        user = TeamMember(name: userName, timezone: selectedTimezone, contact: nil)
        
        if let text = userNameTextField.text, text.isEmpty {
            showAlert(with: "Required field is empty", and: "Please, enter your name")
        } else {
            performSegue(withIdentifier: "openMainVC", sender: nil)
        }
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
