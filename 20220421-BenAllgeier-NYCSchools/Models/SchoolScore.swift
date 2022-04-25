//
//  SchoolScore.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/24/22.
//

import Foundation

struct SchoolScore: Decodable {
    var schoolName: String
    var satCriticalReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String
}
