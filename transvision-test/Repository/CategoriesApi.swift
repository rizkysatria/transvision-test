//
//  CategoriesApi.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import RxSwift

protocol CategoriesApi {
    func getCategories() -> Observable<CategoryResponseModel?>
}
