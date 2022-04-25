//
//  SchoolsList.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/25/22.
//

import SwiftUI

/// This shows a list view of the given schools along with navigation links for showing a selected schools' test scores
struct SchoolsList: View {
    @ObservedObject var viewModel: SchoolsListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.schools) { school in
                NavigationLink {
                    ScoresView(
                        viewModel: .init(
                            school: school,
                            remote: viewModel.scoresRemote
                        )
                    )
                } label: {
                    Text(school.schoolName)
                }
            }
        }
        .listStyle(.plain)
    }
}
