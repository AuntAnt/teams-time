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
    
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var fromStepper: UIStepper!
    
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var toStepper: UIStepper!
    
    @IBOutlet var saveBarButton: UIBarButtonItem!
    
    var user: TeamMember!
    var selectedTimeZone: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = user.name
        
        fromTextField.text = "\(user.workingTime.from):00"
        fromStepper.value = Double(user.workingTime.from)
        
        toTextField.text = "\(user.workingTime.to):00"
        toStepper.value = Double(user.workingTime.to)
        
        timezonePicker.delegate = self
        timezonePicker.dataSource = self
        
        setDefaultTimezone()
        
        nameTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
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
        if !validateWorkingTime() {
            performSegue(withIdentifier: "saveChangesSegue", sender: nil)
        } else {
            showAlert(
                with: "Incorrect working time",
                and: "Your start working time should be less ending time"
            )
        }
    }
    
    @IBAction func fromStepperPressed(_ sender: UIStepper) {
        if sender.tag == 0 {
            fromTextField.text = "\(Int(sender.value)):00"
        } else {
            toTextField.text = "\(Int(sender.value)):00"
        }
    }
    
    // MARK: - private methods
    private func setDefaultTimezone() {
        timezonePicker.selectRow(
            Timezone.allCases.firstIndex(of: user.timezone) ?? 0,
            inComponent: 0,
            animated: true
        )
        
        selectedTimeZone = Timezone.allCases[timezonePicker.selectedRow(inComponent: 0)].rawValue
    }
    
    private func validateWorkingTime() -> Bool {
        fromStepper.value >= toStepper.value
    }
    
    @objc private func textChanged() {
        saveBarButton.isEnabled = !nameTextField.text!.isEmpty
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
