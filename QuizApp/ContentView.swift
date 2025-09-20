//
//  ContentView.swift
//  QuizApp
//
//  Created by Waseem Abbas on 20/09/2025.
//

import SwiftUI
struct Quiz : Identifiable {
    let id = UUID()
    let question : String
    let answers : [String]
    let correctAnswer : String
}

let sampleQuestion: [Quiz] = [
    Quiz(question: "What is the capital of France?", answers: ["Paris", "London", "Berlin", "Rome"], correctAnswer: "Paris"),
    Quiz(question: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars"),
    Quiz(question: "Who created the Swift programming language?", answers: ["Apple", "Google", "Microsoft", "Facebook"], correctAnswer: "Apple"),
    Quiz(question: "What is the largest mammal in the world?", answers: ["Elephant", "Blue Whale", "Giraffe", "Shark"], correctAnswer: "Blue Whale"),
    Quiz(question: "Which gas do plants absorb during photosynthesis?", answers: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], correctAnswer: "Carbon Dioxide"),
    Quiz(question: " In which year was the iPhone first released?", answers: ["2005", "2007", "2009", "2011"], correctAnswer: "2007"),
    Quiz(question: " What is the smallest prime number?", answers: ["0", "1", "2", "3"], correctAnswer: "2"),
    Quiz(question: " Which programming language is mainly used for Android development?", answers: ["Swift", "Java", "Python", "Kotlin"], correctAnswer: "Kotlin"),
    Quiz(question: " Which is the longest river in the world?", answers: ["Nile", "Amazon", "Yangtze", "Ganga"], correctAnswer: "Nile"),
    Quiz(question: " Who painted the Mona Lisa?", answers: ["Leonardo da Vinci", "Pablo Picasso", "Michelangelo", "Vincent van Gogh"], correctAnswer: "Leonardo da Vinci")
]

struct ContentView: View {
    @State var currentIndex : Int = 0
    @State var selectedAnswer : String? = nil
    @State var score = 0
    @State var isWrong : Bool? = nil
    @State var textComplete : Bool? = nil
    let questions = sampleQuestion
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.opacity(0.1).ignoresSafeArea()
                VStack {
                    Text(questions[currentIndex].question)
                        .padding()
                        .font(.title2)
                        .multilineTextAlignment(.center) // center align
                        .lineLimit(3)                    // max 3 lines
                        .truncationMode(.tail)           // show "..." if too long
                        .frame(maxWidth: .infinity)
                        .padding()
                    ForEach(questions[currentIndex].answers, id: \.self) { answer in
                        Button(answer) {
                          selectedAnswer = answer
                            if answer == questions[currentIndex].correctAnswer {
                                score += 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        nextQuestion()
                                        selectedAnswer = nil
                                    }
                                }
                                isWrong = false
                            } else {
                                score -= 1
                                isWrong = true
                                DispatchQueue.main.asyncAfter(deadline:.now() + 2) {
                                    withAnimation {
                                        isWrong = nil
                                        nextQuestion()
                                        selectedAnswer = nil
                                    }
                               
                                }
                               
                            }
                           
                        }
                        .disabled(selectedAnswer != nil)
                        .foregroundStyle(customcolor(for: answer))
                        .frame(width: 300, height: 50)
                        .background(backgroundColor(for: answer))
                        .clipShape(.buttonBorder)

                    }
                   
                    if isWrong == true {
                        Text("Your Answer Is incoorect")
                            .foregroundStyle(Color.red)
                    }
                   
                  Spacer()
                    if textComplete == false {
                        Text("First Complete the test")
                            .foregroundStyle(.red)
                    }  else if textComplete == true {
                        Text("Congrats on Compliting the Task🎉")
                            .foregroundStyle(.red)
                        Text("Want To start Over ?")
                            .foregroundStyle(.red)
                    }
                       
                    Spacer()
                    VStack {
                        Text("Your Score is \(score) out of \(questions.count)")
                    }
                    .frame(width: 500, height: 100)
                    .background(Color.teal.opacity(0.2))
                    
                    Spacer()
                }
                .padding(.top, 30)
            }
            
            .navigationTitle("Quizz App")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Start Over") {
                        startOver()
                    }
                    .foregroundStyle(Color.white)
                    .frame(width: 90, height: 30)
                    .padding(.trailing,6)
                    .background(Color.blue)
                    .cornerRadius(7)
                }
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
    
        }
        textComplete = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
        return .white
    }
    func backgroundColor (for answer : String) -> Color {
        if let selected = selectedAnswer {
            if selected == answer {
                return selected == questions[currentIndex].correctAnswer ? .green.opacity(0.5): .red.opacity(0.5)
            }
        }
        return .gray.opacity(0.5)
    }
}

#Preview {
    ContentView()
}
