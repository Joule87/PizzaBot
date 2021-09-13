//
//  ViewController.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var clarificationLabel: UILabel! {
        didSet {
            clarificationLabel.font = .boldSystemFont(ofSize: 24)
        }
    }
    
    @IBOutlet weak var instructionTextField: UITextField! {
        didSet {
            instructionTextField.delegate = self
        }
    }
    
    @IBOutlet weak var warningLabel: UILabel! {
        didSet {
            warningLabel.text = nil
            warningLabel.textColor = .red
        }
    }
    
    @IBOutlet weak var executeButton: UIButton! {
        didSet {
            executeButton.setTitle("Execute", for: .normal)
            executeButton.backgroundColor = .systemBlue
            executeButton.setTitleColor(.white, for: .normal)
            executeButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var optimizeDeliveryLabel: UILabel! {
        didSet {
            optimizeDeliveryLabel.font = .systemFont(ofSize: 14)
        }
    }
    
    @IBOutlet weak var optimizeDeliverySwitch: UISwitch! {
        didSet {
            optimizeDeliverySwitch.isOn = false
        }
    }
    
    //MARK:- Properties
    lazy var validator: Validatable = InstructionValidator()
    lazy var orderProcessor: Processable = OrderProcessor()
    lazy var pizzaBot: PizzaBot = {
        let routerOptimizer = RouteOptimizer()
        let pizzaBot = PizzaBotAlpha(routeOptimizer: routerOptimizer)
        return pizzaBot
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction
    @IBAction func didTapExecute(_ sender: UIButton) {
        instructionTextField.resignFirstResponder()
        resetLabels()
        
        let instruction = instructionTextField.text
        handleTextField(entry: instruction)
    }
    
}

//MARK:- Helper Functions
extension ViewController {
    
    /// Validates the format of given instruction, if invalid shows a warning.
    /// - Parameter input:Raw instruction
    private func process(input: String) {
        if validator.isValid(instruction: input, regex: OrderRule.gridPlusDeliveryPoints.regex) {
            execute(instruction: input)
        } else {
            setWarningLabel(text: BotInstructionError.invalidFormat.uiDescription)
        }
    }
    
    /// Creates a DeliveryOrder object given a raw instruction  and pass it to the Bot to obtain the Bot's moves. If the order is invalid and error will be shown warning the user of it
    /// - Parameter instruction: Raw instruction
    private func execute(instruction: String) {
        do {
            let deliveryOrder = try orderProcessor.process(order: instruction, rule: OrderRule.gridPlusDeliveryPoints)
            let instruction = pizzaBot.getInstructions(from: deliveryOrder, optimize: optimizeDeliverySwitch.isOn)
            outputLabel.text = "Output: \(instruction)"
        } catch BotInstructionError.invalidPoint {
            setWarningLabel(text: BotInstructionError.invalidPoint.uiDescription)
        } catch BotInstructionError.invalidFormat {
            setWarningLabel(text: BotInstructionError.invalidFormat.uiDescription)
        } catch {
            setWarningLabel(text: "Unexpected error: \(error).")
        }
    }
    
    private func setWarningLabel(text: String?) {
        warningLabel.text = text
    }
    
    private func handleTextField(entry value: String?) {
        guard let text = value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            return
        }
        process(input: text)
    }
    
    private func resetLabels() {
        outputLabel.text = nil
        warningLabel.text = nil
    }
}

//MARK:- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleTextField(entry: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetLabels()
    }
}
