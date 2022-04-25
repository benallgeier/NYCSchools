//
//  NYCSchoolsViewModel.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// A viewmodel that loads an array of NYC schools
class NYCSchoolsViewModel: ObservableObject {
    @Published var schools: [School]?
    // Use to load the NYC schools array
    private let remote = Remote<[School]>.nycSchools
    @Published var error: Error?
    
    /// Possible errors while trying to load schools
    enum SchoolsError: LocalizedError {
        case schoolsDidNotLoad

        var errorDescription: String? {
            switch self {
            case .schoolsDidNotLoad:
                return "Schools did not load"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .schoolsDidNotLoad:
                return "There was an error trying to load the schools"
            }
        }
    }
    
    init() {
        // We keep `schools` in sync with `remote.value`
        remote.$value.assign(to: &$schools)
    }
    
    /// This tries to load `schools` or updates `error` accordingly
    func load() {
        remote.load { [weak self] error in
            guard let self = self else { return }
            if self.remote.value == nil {
                self.error = SchoolsError.schoolsDidNotLoad
            }
        }
    }
}
