//
//  ViewController.swift
//  quizzler
//
//  Created by Ritik Srivastava on 13/08/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var quizProgress: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var choiceView: UIStackView!
    @IBOutlet weak var spaceView: UIView!
    
    var screen = UIScreen.main.bounds
    let quizQuestions = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")

    ]
    
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizProgress.transform = quizProgress.transform.scaledBy(x: 1, y: 2.5)
        screen = UIScreen.main.bounds
        if(screen.height <= 568){
            spaceView.isHidden = true
        }
        updateProgress()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            spaceView.isHidden = true
            choiceView.axis = NSLayoutConstraint.Axis.horizontal
        } else {
            if(screen.height > 568){
                spaceView.isHidden = false
            }
            choiceView.axis = NSLayoutConstraint.Axis.vertical
        }
    }

    @IBAction func choiceTapped(_ sender: Any) {
        if(questionNumber < quizQuestions.count-1){
            let userAnswer = (sender as  AnyObject).currentTitle
            let correctAnswer = quizQuestions[questionNumber].answer
            questionNumber += 1
            showAnswer(isCorrect: userAnswer == correctAnswer, button: userAnswer! ?? "Unknown")
            updateProgress()
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
           
        }else{
            questionNumber = 0;
            updateProgress()
            updateUI()
        }
    }
    
    func showAnswer(isCorrect: Bool,button: String){
        if(button == "True"){
            switch isCorrect{
            case true:
                trueButton.backgroundColor = UIColor.green
                break
            case false:
                trueButton.backgroundColor = UIColor.red
                break
            }
        }else if(button == "False"){
            switch isCorrect{
            case true:
                falseButton.backgroundColor = UIColor.green
                break
            case false:
                falseButton.backgroundColor = UIColor.red
                break
            }
        }
    }
    
    @objc func updateUI(){
        questionLabel.text = quizQuestions[questionNumber].question
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }
    
    func updateProgress(){
        quizProgress.progress = Float(questionNumber+1)/Float(quizQuestions.count)
    }
    
}

