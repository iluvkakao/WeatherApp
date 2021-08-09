//
//  ErrorModel.swift
//  APIExample
//
//  Created by Aleksei Elin on 8.07.21.
//

import Foundation

struct ErrorModel : Codable {
    let message : String?
    let cod : Int?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case cod = "cod"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        cod = try? values.decodeIfPresent(Int.self, forKey: .cod)
    }
}
