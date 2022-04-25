//
//  SchoolScoresViewModel.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// A viewmodel  that can extract out SAT test scores for a given school and access to an array of schools scores via a `Remote` object
class SchoolScoresViewModel: ObservableObject {
    @Published var scores: SchoolScore?
    @Published var remote: Remote<[SchoolScore]>
    @Published var error: Swift.Error?
    
    private let school: School
    var schoolName: String {
        school.schoolName
    }
    
    /// Possible errors while trying to determine the set of test scores
    enum ScoresError: LocalizedError {
        case scoresDidNotLoad
        case noScoresProvided

        var errorDescription: String? {
            switch self {
            case .scoresDidNotLoad:
                return "Scores did not load"
            case .noScoresProvided:
                return "No scores provided"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .scoresDidNotLoad:
                return "There was an error trying to load the scores"
            case .noScoresProvided:
                return "None of the loaded scores match the school"
            }
        }
    }
    
    init(
        school: School,
        remote: Remote<[SchoolScore]>
    ) {
        self.school = school
        self.remote = remote
    }
    
    /// This loads the school scores and sets `scores` if one corresponds to `school` or updates `error` accordingly
    func load() {
        remote.load { [weak self] error in
            guard let self = self else { return }
            guard let allScores = self.remote.value else {
                self.error = ScoresError.scoresDidNotLoad
                return
            }
            // To allow flexibility matching school names, we compare names after being lowercased
            guard let scores = allScores.first(where: {
                $0.schoolName.lowercased() == self.school.schoolName.lowercased()
            }) else {
                self.error = ScoresError.noScoresProvided
                return
            }
            self.scores = scores
        }
    }
}
