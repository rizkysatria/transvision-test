//
//  MainViewModel.swift
//  transvision-test
//
//  Created by rizky satria on 21/06/23.
//

import Foundation
import Alamofire
import RxSwift

class MainViewModel {
    
    var rxEventLoadCollectionView: PublishSubject<Void> { eventLoadCollectionView }
    var rxEventLoadTableView: PublishSubject<Void> { eventLoadTableView }
    
    private (set) var categoryList: [CategoryResponseModel.ResultModel]?
    private (set) var couponList: [CouponResponseModel.ResultModel]?
    private (set) var couponListResponse: [CouponResponseModel.ResultModel]?
    private (set) var selectedTabbarId: String?
    
    private let eventLoadCollectionView = PublishSubject<Void>()
    private let eventLoadTableView = PublishSubject<Void>()
    private let provider: NetworkService = NetworkServiceImpl()
    private let categoriesApi = CategoriesApiImpl()
    private let couponApi = CouponApiImpl()
    private let disposeBag = DisposeBag()
    
    init() {
    }
    
    func viewDidLoad() {
        getCategories()
        getCoupon()
    }
    
    func setSelectedTabbarId(selectedId: String) {
        guard selectedId != "" else { return }
        selectedTabbarId = selectedId

        if selectedId == "all" {
            couponList = couponListResponse
        } else {
            let couponList = couponListResponse
            let filteredCouponList = couponList?.filter({ $0.couponCategoryID == selectedId })
            self.couponList = filteredCouponList
        }
        eventLoadTableView.onNext(())
        eventLoadCollectionView.onNext(())
    }
    
    func getCategories() {
        categoriesApi.getCategories()
            .subscribe(onNext: { [weak self] categoryModel in
                guard let weakSelf = self, let categoryList = categoryModel?.result else { return }
                weakSelf.categoryList = categoryList
                weakSelf.insertAllCategory()
                weakSelf.eventLoadCollectionView.onNext(())
        }).disposed(by: disposeBag)
    }
    
    func getCoupon() {
        couponApi.getCouponList()
            .subscribe(onNext: { [weak self] couponResponse in
                guard let weakSelf = self, let couponList = couponResponse?.result else { return }
                weakSelf.couponList = couponList
                weakSelf.couponListResponse = couponList
                weakSelf.eventLoadTableView.onNext(())
            }).disposed(by: disposeBag)
    }
    
    private func insertAllCategory() {
        let allCategory = CategoryResponseModel.ResultModel(categoryID: "all", categoryName: "All")
        selectedTabbarId = "all"
        categoryList?.insert(allCategory, at: 0)
    }
    
}
