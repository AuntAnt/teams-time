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
    
    private var user: TeamMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeZonePicker?.dataSource = self
        timeZonePicker?.delegate = self
        
        loginButton.layer.cornerRadius = 8
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let mainVC = segue.destination as? MainViewController else { return }
//        mainVC.userName = user?.name
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    

    @IBAction func logInPressed() {
        guard let userName = userNameTextField.text else { return }
        user = TeamMember.getMembers().first(where: { $0.name == userName })
        guard user != nil else {
            showAlert(
                title: "Invalid login",
                message: "Please, enter correct login",
                textField: userNameTextField
            )
            return
        }
        performSegue(withIdentifier: "openMainVC", sender: nil)
    }
    
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension LoginViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timezone.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Timezone.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
}

extension LoginViewController: UIPickerViewDelegate {
}


