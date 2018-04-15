//
//  BaseController.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import PKHUD
import UIKit

class BaseViewController: UIViewController {
    // MARK: - HUD
    func showLoading() {
        HUD.show(.progress)
    }
    
    func showLoadingSuccess(completion: (() -> Void)? = nil) {
        HUD.flash(.success, delay: 0.5) { (finished) in
            if finished {
                completion?()
            }
        }
    }
    
    func showFailure(text: String? = nil) {
        if let text = text {
            HUD.flash(.labeledError(title: PublicConstants.error,
                                    subtitle: text), delay: 2.0)
        } else {
            HUD.flash(.error, delay: 1.0)
        }
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    // MARK: - Alert
    func showAlert(withMessage msg: String) {
        let alert = UIAlertController(title: "Внимание!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Повтор", style: .cancel, handler: { [weak self] _ in
            self?.retry()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func retry() {
        
    }
}

extension BaseViewController: StoryboardSceneBased {
    /// Название сториборда берётся по первому слову из названия контроллера.
    /// Пример: PrecheckHistoryViewController -> Precheck
    ///
    /// Там где есть различия в неймниге, надо переопределить это свойство.
    ///
    static var sceneStoryboard: UIStoryboard {
        let name = String(describing: self)
        let splitted = name
            .splitBefore(separator: { $0.isUpperCase })
            .map { String($0) }
        return UIStoryboard(name: splitted.first ?? "", bundle: nil)
    }
}
