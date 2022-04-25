//
//  ScoresView.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// A view that shows a school's math, reading, and writing SAT scores
struct ScoresView: View {
    @ObservedObject var viewModel: SchoolScoresViewModel
    
    var body: some View {
        if let scores = viewModel.scores {
            scoresView(for: scores)
        } else {
            ProgressView()
                .onAppear { self.viewModel.load() }
                .errorAlert(error: $viewModel.error)
            // Note that after the alert is dismissed, the progress view is still spinning - probably would want to update the UI in some way after the alert is dismissed.
            // Also, would probably add in a general view to handle whether to show a progress view or the main content based on the state of the view model
        }
    }
    
    private func scoresView(for scores: SchoolScore) -> some View {
        VStack {
            Text(viewModel.schoolName)
                .font(.title2)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 24)
            HStack {
                Spacer()
                
                VStack {
                    Text("Math")
                    Text(scores.satMathAvgScore)
                }
                
                Spacer()
                
                VStack {
                    Text("Reading")
                    Text(scores.satCriticalReadingAvgScore)
                }
                
                Spacer()
                
                VStack {
                    Text("Writing")
                    Text(scores.satWritingAvgScore)
                }
                
                Spacer()
            }
            .padding(.vertical)
            .font(.headline)
            .foregroundColor(.white)
            .background(Rectangle().fill(Color.black))
            
            Spacer()
        }
        .padding()
    }
}
