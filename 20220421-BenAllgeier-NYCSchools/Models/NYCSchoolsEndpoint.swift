//
//  NYCSchoolsEndpoint.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/24/22.
//

import Foundation

/// URLs needed for fetching NYC schools and scores data
enum NYCSchoolsEndpoint {
    case schools
    case scores
    
    // TODO: Add tests that these return valid urls
    var url: URL {
        switch self {
        case .schools:
            return URL("https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
        case .scores:
            return URL("https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
        }
    }
}

extension URL {
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
}
