//
//  ViewController.swift
//  calc
//
//  Created by Yogesh Kumar on 07/02/16.
//  Copyright © 2016 itsyogesh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    var leftVar = ""
    var rightVar = ""
    var currentOperation : Operation = Operation.Empty;
    var result = ""
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(btn: UIButton!) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(btn: UIButton!) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(btn: UIButton!) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(btn: UIButton!) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(btn: UIButton!) {
        processOperation(currentOperation)
    }
    
    func processOperation (op: Operation) {
        playSound()
        
        if(currentOperation != Operation.Empty) {
            rightVar = runningNumber
            runningNumber = ""
            result = String(math(Double(leftVar)!, secondVal: Double(rightVar)!, op: op))
            runningNumber = "\(result)"
            
            leftVar = result
            outputLabel.text = result
            
        } else {
            leftVar = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func math (firstVal: Double, secondVal: Double, op: Operation) -> Double {
        if(op == Operation.Add) {
            return firstVal + secondVal
        }
        
        if(op == Operation.Subtract) {
            return firstVal - secondVal
        }
        
        if(op == Operation.Multiply) {
            return firstVal * secondVal
        }
        
        if(op == Operation.Divide) {
            return firstVal / secondVal
        }
        
        return 0
    }
    
    func playSound () {
        if(btnSound.playing) {
            btnSound.stop()
        }
        btnSound.play()
    }
}

