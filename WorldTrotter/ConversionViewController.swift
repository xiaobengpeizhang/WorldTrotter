//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 杨佩璋 on 2017/10/13.
//  Copyright © 2017年 杨佩璋. All rights reserved.
//

import Foundation
import UIKit
// 温度转换控制器
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!    // 摄氏温度栏
    @IBOutlet var textField: UITextField!   // 输入华氏温度的文本框
    
    var fahrenheitValue: Measurement<UnitTemperature>? {    // 华氏温度值
        didSet {
            updateCelsiusLabel()    // 每次华氏温度改变时更新摄氏温度栏
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()    
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConvertionViewController is loaded")
        updateCelsiusLabel()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let localSeperator = Locale.current.decimalSeparator ?? "."
        let existSeperatorRange = textField.text?.range(of: localSeperator)
        let replaceSeperatorRange = string.range(of: localSeperator)
        if existSeperatorRange != nil, replaceSeperatorRange != nil {
            return false
        } else {
            return true
        }
    }
}
