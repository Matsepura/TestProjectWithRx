//
//  CountryInfoViewController.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import RxSwift
import UIKit

final class CountryInfoViewController: BaseViewController {
    @IBOutlet weak var infoTextView: UITextView!
    
    var coordinator: CountryInfoCoordinator?
    let viewModel = CountryInfoViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        viewModel.obtainCountry()
    }

    private func setupRx() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] (state) in
                guard let `self` = self else { return }
                switch state {
                case .zero:
                    print("zero state")
                case .loading:
                        self.showLoading()
                case .failure(let message):
                    self.hideLoading()
                    self.showAlert(withMessage: message)
                case .success:
                    self.infoTextView.text = self.viewModel.countryViewModel?.info
                    self.hideLoading()
                }
            }).disposed(by: disposeBag)
    }
    
    override func retry() {
        viewModel.obtainCountry()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        coordinator?.stop()
    }
}
