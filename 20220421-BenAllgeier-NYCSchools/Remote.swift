//
//  Remote.swift
//  20220421-BenAllgeier-NYCSchools
//
//  Created by Benjamin Allgeier on 4/24/22.
//

import Foundation

/// A generic class for making network calls to fetch and store data from a given url
final class Remote<A>: ObservableObject {
    enum LoadError: Error {
        case unknown
        case parsing
    }
    
    let url: URL
    let parse: (Data) throws -> A
    @Published var value: A?
    
    init(
        url: URL,
        parse: @escaping (Data) throws -> A)
    {
        self.url = url
        self.parse = parse
    }
    
    /// If `value` is nil, this makes a network call and parses the returns data. An optional completion handler passes back an loading error if one occurs
    func load(completion: ((LoadError?)  -> Void)? = nil) {
        let main = DispatchQueue.main
        guard value == nil else {
            completion?(nil)
            return
        }
        // TODO: More robust checking of error and response
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion?(.unknown)
                return
            }
            do {
                let result = try self.parse(data)
                main.async {
                    self.value = result
                    completion?(nil)
                }
            } catch {
                completion?(.parsing)
            }
        }.resume()
    }
}

extension Remote where A: Decodable {
    /// A convenience init to use `JSONDecoder` with `keyDecodingStrategy` set as `.convertFromSnakeCase` provided `A` is `Decodable`
    convenience init(url: URL) {
        self.init(
            url: url,
            parse: { data in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(A.self, from: data)
            }
        )
    }
}

/// Concrete remotes
extension Remote {
    static var nycSchools: Remote<[School]> {
        Remote<[School]>(url: NYCSchoolsEndpoint.schools.url)
    }
    
    static var nycSchoolScores: Remote<[SchoolScore]> {
        Remote<[SchoolScore]>(url: NYCSchoolsEndpoint.scores.url)
    }
}
