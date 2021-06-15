//
//  GenericJsonParser.swift
//  GG
//
//  Created by hmbp on 1/21/20.
//  Copyright © 2020 hmbp. All rights reserved.
//

import Foundation

class GenericJsonParser {
    
    static func load<T: Decodable>(_ fileName: String, as Type: T.Type = T.self) -> T {
        let data: Data!
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("Couldn't find \(fileName) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't laod \(fileName) from main bundle.\nerror::\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(fileName) as \(T.self)\nerror::\(error)")
        }
    }
}




class UseClass {
    struct UseType: Decodable {
        let title: String
    }
    
    init() {
        let parsedJson = GenericJsonParser.load("", as: UseType.self)
        print(parsedJson)
    }
}
