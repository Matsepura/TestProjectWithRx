import UIKit

/// Использовать этот протокол для случаев когда ячейки:
/// являются NIB-based И класс является File's owner'ом XIB'a

public protocol NibOwnerLoadable: class {
  static var nib: UINib { get }
}

public extension NibOwnerLoadable {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

public extension NibOwnerLoadable where Self: UIView {
  func loadNibContent() {
    let layoutAttributes: [NSLayoutAttribute] = [.top, .leading, .bottom, .trailing]
    for view in Self.nib.instantiate(withOwner: self, options: nil) {
      if let view = view as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        layoutAttributes.forEach { attribute in
          self.addConstraint(NSLayoutConstraint(item: view,
            attribute: attribute,
            relatedBy: .equal,
            toItem: self,
            attribute: attribute,
            multiplier: 1,
            constant: 0.0))
        }
      }
    }
  }
}
