//
//  SettingsViewController.swift
//  teams-time
//
//  Created by Anton Kuzmin on 12.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var timezonePicker: UIPickerView!
    
    var user: TeamMember!
    var selectedTimeZone: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = user.name
        timezonePicker.delegate = self
        timezonePicker.dataSource = self
        
        setDefaultTimezone()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        if let text = nameTextField.text, !text.isEmpty {
            performSegue(withIdentifier: "saveChangesSegue", sender: nil)
        } else {
            showAlert(with: "Name can't be empty", and: "Please fill in the name field")
        }
    }
    
    private func setDefaultTimezone() {
        timezonePicker.selectRow(
            Timezone.allCases.firstIndex(of: user.timezone) ?? 0,
            inComponent: 0,
            animated: true
        )
        
        selectedTimeZone = Timezone.allCases[timezonePicker.selectedRow(inComponent: 0)].rawValue
    }
}

//MARK: - UIPicker source and delegate
extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Timezone.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Timezone.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTimeZone = Timezone.allCases[row].rawValue
    }
}
