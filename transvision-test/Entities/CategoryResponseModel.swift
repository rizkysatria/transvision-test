//
//  CategoryResponseModel.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import AnyCodable

struct CategoryResponseModel: Codable {
    let status: Bool?
    let statusCode: String?
    let result: [ResultModel]?
    let option: String?
    let message: [String]?
    
    // MARK: - Result
    struct ResultModel: Codable {
        let categoryID, categoryName: String?

        enum CodingKeys: String, CodingKey {
            case categoryID = "categoryId"
            case categoryName
        }
    }
    
}


