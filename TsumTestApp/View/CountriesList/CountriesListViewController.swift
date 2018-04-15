//
//  CountriesListViewController.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CountriesListViewController: BaseViewController {
    private enum Constants {
        static let title = "Countries List"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CountriesListViewModel()
    var coordinator: CountryListCoordinator?
    
    private let refreshControl = UIRefreshControl()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        setupTableView()
        setupRx()
        viewModel.obtain()
    }
    
    private func setupTableView() {
        tableView.register(cellType: CountryListCell.self)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.delegate = viewModel.tableViewModel
        tableView.dataSource = viewModel.tableViewModel
    }
    
    private func setupRx() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe({ [weak self] _ in self?.viewModel.obtain() })
            .disposed(by: disposeBag)
        
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let `self` = self else { return }
                switch state {
                case .zero:
                    print("zero state")
                case .loading:
                    if !self.refreshControl.isRefreshing {
                        self.showLoading()
                    }
                case .failure(let message):
                    self.hideLoading()
                    self.showAlert(withMessage: message)
                case .success:
                    self.hideLoading()
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }).disposed(by: disposeBag)
        
        viewModel.tableViewModel.selectOutlet.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] (name) in
                self?.coordinator?.showCountryInfo(by: name)
            }).disposed(by: disposeBag)
    }
    
    override func retry() {
        viewModel.obtain()
    }
}
