//
//  ViewController.swift
//  Temprature converter
//
//  Created by Monika Patel on 15/12/20.
//

import UIKit

class TempConverterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var degreeTxtfield: UITextField!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var tempratureSegment: UISegmentedControl!
    @IBOutlet var resultLabel: UILabel!
    let mf = MeasurementFormatter()
    var celsiusResult: String = ""
    var FahrenheitResult: String = ""
    var kelvinResult: String = ""
    var selectedUnitIdx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
     }
    //MARK: - Apply Basic value and design
    func initialisation(){
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)

        resultButton.layer.cornerRadius = 8
        tempratureSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 16.0)!], for: .normal)

        selectedUnitIdx = tempratureSegment.selectedSegmentIndex
        
        degreeTxtfield.delegate = self
        addShadowView(aView: degreeTxtfield)
        addShadowView(aView: tempratureSegment)
        addShadowView(aView: resultButton)
    }
    // MARK: - Number Validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "0123456789.-"
        return allowedCharacters.contains(string) || range.length == 1

        
    }
    // MARK: - Unit Selection
    @IBAction func chooseSegment(_ sender: UISegmentedControl) {
        self.degreeTxtfield.resignFirstResponder()
        resultLabel.text = "-"
        selectedUnitIdx = sender.selectedSegmentIndex
    }
    // MARK: - Convert Button Click Event
    @IBAction func convertTapped(_ sender: Any) {
        self.degreeTxtfield.resignFirstResponder()

        if(!self.degreeTxtfield.text!.isEmpty)
        {
            let degreeVal = Double(self.degreeTxtfield.text!)

            if(selectedUnitIdx == 0){ //celsius selected
                 FahrenheitResult = convertTemp(temp: Double(degreeVal!), from: .celsius, to: .fahrenheit)
                 kelvinResult = convertTemp(temp: Double(degreeVal!), from: .celsius, to: .kelvin)

                resultLabel.text = "\(FahrenheitResult)\n\(kelvinResult)"
                
            }else if (selectedUnitIdx == 1){//Fahrenheit selected
                 celsiusResult = convertTemp(temp: Double(degreeVal!), from: .fahrenheit, to: .celsius)
                 kelvinResult = convertTemp(temp: Double(degreeVal!), from: .fahrenheit, to: .kelvin)

                 resultLabel.text = "\(celsiusResult)\n\(kelvinResult)"
            }
            else{//Kelvin selected

                 celsiusResult = convertTemp(temp: Double(degreeVal!), from: .kelvin, to: .celsius)
                 FahrenheitResult = convertTemp(temp: Double(degreeVal!), from: .kelvin, to: .fahrenheit)

                resultLabel.text = "\(celsiusResult)\n\(FahrenheitResult)"
            }
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "Please enter degree.", preferredStyle: .alert)
                
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
               
                 DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
            })
        }
    }
    // MARK: - Convert Temprature
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        mf.numberFormatter.maximumFractionDigits = 3
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
      }
    
    // MARK: - Apply Shadow
    func addShadowView(aView: UIView){
        aView.layer.shadowColor = UIColor.black.cgColor
        aView.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        aView.layer.shadowRadius = 8
        aView.layer.shadowOpacity = 0.5
        aView.layer.masksToBounds = false
    }

}
