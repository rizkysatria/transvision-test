//
//  NetworkService.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import RxSwift

protocol NetworkService {
    func get(urlString: String) -> Observable<Any?>
}
