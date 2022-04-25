//
//  NYCSchoolsView.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// A list view of NYC schools wrapped in a `NavigationView`
struct NYCSchoolsView: View {
    @ObservedObject var viewModel = NYCSchoolsViewModel()
    
    var body: some View {
        if let schools = viewModel.schools {
            NavigationView {
                SchoolsList(viewModel: .init(schools: schools))
                    .navigationTitle("NYC Schools")
            }
        } else {
            ProgressView()
                .onAppear { self.viewModel.load() }
                .errorAlert(error: $viewModel.error)
        }
    }
}
