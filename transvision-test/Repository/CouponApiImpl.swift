//
//  CouponApiImpl.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import RxSwift

class CouponApiImpl {
    
    let networkService = NetworkServiceImpl()
    
    func getCouponList() -> Observable<CouponResponseModel?> {
        return networkService.get(urlString: "https://requestly.dev/api/mockv2/getCoupon?username=user1673281842743").map { response in
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData =  try JSONSerialization.data(withJSONObject: data)
                    let decode = try JSONDecoder().decode(CouponResponseModel.self, from: jsonData)
                    return decode
                }
            }
            return nil
        }
    }
}
