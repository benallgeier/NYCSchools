//
//  SchoolsListViewModel.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// A viewmodel for showing a list of schools
class SchoolsListViewModel: ObservableObject {
    @Published var schools: [School]
    // To avoid having to make the network call for the school scores every time the user navigates to the detail screen, we pass this scores remote for every detail view
    let scoresRemote: Remote<[SchoolScore]> = Remote<[SchoolScore]>.nycSchoolScores
    
    init(schools: [School]) {
        self.schools = schools
    }
}
