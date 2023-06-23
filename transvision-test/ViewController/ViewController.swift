//
//  ViewController.swift
//  transvision-test
//
//  Created by rizky satria on 21/06/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupCollectionView()
        setupViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VoucherTableViewCell", bundle: nil), forCellReuseIdentifier: "VoucherTableViewCell")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TabbarCell", bundle: nil), forCellWithReuseIdentifier: "TabbarCell")
    }
    
    private func setupViewModel() {
        viewModel.rxEventLoadCollectionView
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.rxEventLoadTableView
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.couponList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VoucherTableViewCell") as? VoucherTableViewCell, let couponList = viewModel.couponList else { return UITableViewCell() }
        let data = couponList[indexPath.row]
        cell.configureCell(imgUrl: data.couponBrandLogo ?? "", name: data.couponName ?? "", value: data.couponBenefitValue ?? "", expiredDate: data.couponEndDate ?? "")
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbarCell", for: indexPath) as? TabbarCell, let categoryList = viewModel.categoryList else { return UICollectionViewCell() }
        let data = categoryList[indexPath.row]
        let isSelected = data.categoryID == viewModel.selectedTabbarId
        cell.configureCell(title: data.categoryName ?? "", selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categoryList = viewModel.categoryList else { return }
        viewModel.setSelectedTabbarId(selectedId: categoryList[indexPath.row].categoryID ?? "")
    }
    
}
