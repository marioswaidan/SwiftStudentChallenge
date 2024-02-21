//
//  Questions.swift
//  SwiftStudentChallenge
//
//  Created by Mario Swaidan on 2/21/24.
//

import SwiftUI

struct Question: Identifiable, Hashable {
    
    let id = UUID()
    let questionText : String
    let answerOne : String
    let answerTwo : String
    let answerThree : String
    let answerFour : String
    let correctAnswer : String
    
}


struct Questions: View {

    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var score = 0
    
    let questions: [Question] = [
        Question(questionText: "How high can a drone fly?", answerOne: "400 feet", answerTwo: "200 feet", answerThree: "300 feet", answerFour: "800 feet", correctAnswer: "400 feet"),
        Question(questionText: "What is the name of the Commercial Drone Pilot Certification?", answerOne: "FAA 14 CFR Part 107", answerTwo: "FAA TRUST Certification", answerThree: "FAA Recreation Drone Pilots License", answerFour: "FAA Part 113", correctAnswer: "FAA 14 CFR Part 107"),
        Question(questionText: "How often do you have to renew your Commercial Drone Pilots License?", answerOne: "Every two years.", answerTwo: "Every year.", answerThree: "Every three years.", answerFour: "Every five years.", correctAnswer: "Every two years.")
    ]
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    var allAnswers: [String] {
        [currentQuestion.answerOne, currentQuestion.answerTwo, currentQuestion.answerThree, currentQuestion.answerFour].compactMap { $0 }
    }
    
    var body: some View {
        
        ZStack {
            Color.cyan
                .edgesIgnoringSafeArea(.top)
            VStack {
                Spacer()
                Text(currentQuestion.questionText)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
                ForEach(allAnswers, id: \.self) { answer in
                    Button(action: {
                        answerButtonTapped(answer)
                    }) {
                        Text(answer)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedAnswer == answer
                                ? (answer == currentQuestion.correctAnswer ? Color.green : Color.red)
                                : Color.white
                            )
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .disabled(selectedAnswer != nil)
                    
                }
                Spacer()
            }
            .padding()
        }
        
    }
    
    func answerButtonTapped(_ answer: String) {
        selectedAnswer = answer
        
        if answer == currentQuestion.correctAnswer {
            score += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
        } else {
            print("Quiz completed. Score: \(score)")
        }
    }
}

#Preview {
    Questions()
}
