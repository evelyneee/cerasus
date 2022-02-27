//
//  JSON.swift
//  
//
//  Created by charlotte on 2022-02-27.
//

import Foundation

extension Encodable {
    func jsonString() throws -> String {
        let encoded = try JSONEncoder().encode(self)
        let string = try encoded.utf8()
        return string
    }
}

//extension Collection {
//    func jsonString() throws -> String {
//        let encoded = try JSONSerialization.data(withJSONObject: self, options: [])
//        let string = try encoded.utf8()
//        return string
//    }
//}

fileprivate extension Data {
    
    enum StringErrors: Error {
        case badUTF8
    }
    
    func utf8() throws -> String {
        guard let string = String(data: self, encoding: .utf8) else { throw Self.StringErrors.badUTF8 }
        return string
    }
}
