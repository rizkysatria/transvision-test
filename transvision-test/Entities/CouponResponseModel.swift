//
//  CouponResponseModel.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import AnyCodable

struct CouponResponseModel: Codable {
    let status: Bool?
    let statusCode: String?
    let result: [ResultModel]?
    let option: String?
    let message: [String]?
    
    // MARK: - Result
    struct ResultModel: Codable {
        let couponID, couponName, couponBrandName: String?
        let couponBrandLogo: String?
        let couponBenefitType, couponBenefitValue: String?
        let couponBenefitUnit: AnyCodable?
        let couponQuota, couponCategoryID, couponCategoryName, couponTNC: String?
        let couponStatus, couponStartDate, couponEndDate, couponCreatedAt: String?
        let couponUpdatedAt: String?

        enum CodingKeys: String, CodingKey {
            case couponID = "couponId"
            case couponName, couponBrandName, couponBrandLogo, couponBenefitType, couponBenefitValue, couponBenefitUnit, couponQuota
            case couponCategoryID = "couponCategoryId"
            case couponCategoryName
            case couponTNC = "couponTnc"
            case couponStatus, couponStartDate, couponEndDate, couponCreatedAt, couponUpdatedAt
        }
    }
}


