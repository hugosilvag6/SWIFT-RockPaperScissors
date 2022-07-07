//
//  ContentView.swift
//  rockPaperScissors
//
//  Created by Hugo Silva on 06/07/22.
//

import SwiftUI

struct Guidelines: View {
    var text: String
    var color: Color = .red
    var body: some View {
        Text(text)
            .font(.largeTitle.bold())
            .padding()
            .background(color)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}

struct ContentView: View {
    @State private var choices = ["ROCK", "PAPER", "SCISSORS"]
    @State private var winOrLose = Bool.random()
    @State private var appChoice = Int.random(in: 0...2)
    @State private var alertMsg = ""
    @State private var showingAlert = false
    @State private var score = 0
    @State private var currentTries = 0
    @State private var maxTries = 10
    @State private var finalScore = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Text("Current pick:").font(.title)
                Guidelines(text: "\(choices[appChoice])")
                Text("Choose the correct optin to:").font(.title)
                Guidelines(text: winOrLose ? "WIN" : "LOSE")
                Spacer()
                Spacer()
                ForEach(0..<3) { number in
                    Button {
                        tapped(choices[number])
                    } label: {
                        Guidelines(text: choices[number], color: .blue)
                    }
                }
                Spacer()
                Text("SCORE: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .foregroundColor(.white)
        }
        .alert(alertMsg, isPresented: $showingAlert){
            Button("Continue", action: shuffleOptions)
        } message: {
            Text("Your score is \(finalScore)")
        }
    }
    
    func tapped (_ choice: String) {
        if currentTries < maxTries-1 {
            checkAnswer(choice)
        } else {
            checkAnswer(choice)
            alertMsg = "YOU HAVE FINISHED THE GAME!"
            finalScore = score
            score = 0
            currentTries = 0
        }
        showingAlert = true
    }
    func shuffleOptions() {
        choices.shuffle()
        winOrLose = Bool.random()
        appChoice = Int.random(in: 0...2)
    }
    func checkAnswer(_ choice: String) {
        if choices[appChoice] == "ROCK" {
            if (choice == "PAPER" && winOrLose) || (choice == "SCISSORS" && !winOrLose) {
                alertMsg = "Correct!"
                score += 1
                currentTries += 1
                finalScore = score
            } else {
                alertMsg = "Wrong!"
                currentTries += 1
            }
        }
        if choices[appChoice] == "PAPER" {
            if (choice == "SCISSORS" && winOrLose) || (choice == "ROCK" && !winOrLose) {
                alertMsg = "Correct!"
                score += 1
                currentTries += 1
                finalScore = score
            } else {
                alertMsg = "Wrong!"
                currentTries += 1
            }
        }
        if choices[appChoice] == "SCISSORS" {
            if (choice == "ROCK" && winOrLose) || (choice == "PAPER" && !winOrLose) {
                alertMsg = "Correct!"
                score += 1
                currentTries += 1
                finalScore = score
            } else {
                alertMsg = "Wrong!"
                currentTries += 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
