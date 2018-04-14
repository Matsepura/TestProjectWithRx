//
//  CountriesListTableViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import RxSwift
import UIKit

final class CountriesListTableViewModel: NSObject {
    var viewModels: [CountryListViewModel] = []
    let selectOutlet: Variable<String> = Variable("")
    
    fileprivate var cellMapper: CellMapper {
        return { (viewModel) in
            switch viewModel {
            case is CountryListViewModel:
                return CountryListCell.self
            default:
                assertionFailure("Wrong Type!")
                return UITableViewCell.self
            }
        }
    }
}

extension CountriesListTableViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cellIdentifier = String(describing: cellMapper(viewModel))
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        (cell as? ViewModelConfigurable)?.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModels[indexPath.row].name)
        selectOutlet.value = viewModels[indexPath.row].name
    }
}
