//
//  NetworkServiceImpl.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import UIKit
import RxSwift
import Alamofire

class NetworkServiceImpl: NetworkService {
    
    func get(urlString: String) -> Observable<Any?> {
        return doRequest(urlString: urlString, method: .get)
    }
    
    private func doRequest(urlString: String, method: HTTPMethod) -> Observable<Any?> {
        let request = Alamofire.request(urlString, method: .get).validate()
        return Observable<Any?>.create { [weak self] (observer) -> Disposable in
            guard let weakSelf = self else { return Disposables.create() }
            request.responseJSON { response in
                switch response.result {
                case .success(let response):
                    observer.onNext(response)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
