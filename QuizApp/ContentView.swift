//
//  ContentView.swift
//  QuizApp
//
//  Created by Waseem Abbas on 20/09/2025.
//

import SwiftUI
struct Quizz : Identifiable {
    let id = UUID()
    let question : String
    let answers : [String]
    let correctAnswer : String
}

let sampleQuestion : [Quizz] = [Quizz(question: "What is the capital of France?", answers: ["Paris", "London", "Berlin", "Rome"], correctAnswer: "Paris"),
Quizz(question: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars"),
Quizz(question: "Who created the Swift programming language?", answers: ["Apple", "Google", "Microsoft", "Facebook"], correctAnswer: "Apple")]
struct ContentView: View {
    @State var currentIndex : Int = 0
    @State var selectedAnswer : String? = nil
    @State var score = 0
    @State var isWrong : Bool? = nil
    @State var textComplete : Bool? = nil
    let questions = sampleQuestion
    var body: some View {
        VStack {
            Text(questions[currentIndex].question)
            ForEach(questions[currentIndex].answers, id: \.self) { answer in
                Button(answer) {
                  selectedAnswer = answer
                    if answer == questions[currentIndex].correctAnswer {
                        score += 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                nextQuestion()
                            }
                        }
                        isWrong = false
                    } else {
                        isWrong = true
                        DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                            isWrong = nil
                        }
                       
                    }
                   
                }
                .foregroundStyle(customcolor(for: answer))
//                .background(customcolor(for: answer))

            }
            Button("Start Over") {
                startOver()
            }
            if isWrong == true {
                Text("Your Answer Is incoorect")
                    .foregroundStyle(Color.red)
            }
           
            Text("Your Score is \(score)")
            if textComplete == false {
                Text("First Complete the test")
            }  else if textComplete == true {
                Text("Congrats on Compliting the Task🎉")
                Text("Want To start Over ?")
            }
               
        }
        
        
    }
    
    
//    MARK: Helpers Functions
    
    func nextQuestion () {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
           textComplete = true
        }
    }
    func startOver () {
        if currentIndex == questions.count - 1 {
            currentIndex = 0
            score = 0
            textComplete = true
        }
        textComplete = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                textComplete = nil
            }
           
        }
       
    }
    func customcolor (for answer : String) -> Color {
    if let selected = selectedAnswer {
                  if selected == answer {
                      return selected == questions[currentIndex].correctAnswer ? .green : .red
                  }
              }
              return .blue
    }
}

#Preview {
    ContentView()
}
