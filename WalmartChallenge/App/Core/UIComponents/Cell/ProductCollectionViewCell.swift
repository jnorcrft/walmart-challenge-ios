import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
  private let view = ProductView()

  func configure(_ viewData: ProductViewData) {
    contentView.backgroundColor = .clear
    contentView.addSubview(view.autolayout())
    NSLayoutConstraint.activate(view.constraints(anchoredTo: contentView))
    view.configure(viewData)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    view.prepareForReuse()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.layoutIfNeeded()
  }
}
