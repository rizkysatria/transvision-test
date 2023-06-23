//
//  CategoriesApiImpl.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import RxSwift

class CategoriesApiImpl: CategoriesApi {
    
    let networkService = NetworkServiceImpl()
    
    func getCategories() -> Observable<CategoryResponseModel?> {
        return networkService.get(urlString: "https://requestly.dev/api/mockv2/getAllCategory?username=user1673281842743").map { response in
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData =  try JSONSerialization.data(withJSONObject: data)
                    let decode = try JSONDecoder().decode(CategoryResponseModel.self, from: jsonData)
                    return decode
                }
            }
            return nil
        }
    }
}
