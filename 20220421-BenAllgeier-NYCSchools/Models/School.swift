//
//  School.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/24/22.
//

import Foundation

struct School: Decodable, Identifiable {
    var schoolName: String
    var id: String { schoolName }
}
