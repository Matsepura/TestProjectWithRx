//
//  CountryListCell.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

final class CountryListCell: UITableViewCell, NibReusable, AnyViewModelConfigurable {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    
    func configure(with viewModel: CountryListViewModel) {
        name.text = viewModel.name
        population.text = viewModel.population
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        population.text = nil
    }
}
