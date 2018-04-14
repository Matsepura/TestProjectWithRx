import UIKit

public protocol NibLoadable: class {
  static var nib: UINib { get }
}

public extension NibLoadable {
  /// По умолчанию используем название nib файла идентичное имени класса
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

// MARK: Поддержка загрузки из nib

public extension NibLoadable where Self: UIView {
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("nib файл \(nib) должен иметь корневую view типа \(self)")
    }
    return view
  }
}
