import UIKit

final class TableHeaderView: UIView {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .extraLargeTitle2)
    label.textAlignment = .left
    return label
  }()

  init(frame: CGRect, text: String) {
    super.init(frame: frame)
    setupViews(withText: text)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews(withText text: String) {
    backgroundColor = .clear
    titleLabel.text = text
    addSubview(titleLabel.autolayout())
    NSLayoutConstraint.activate(titleLabel.constraints(anchoredTo: self, padding: Layout.Spacing.spacing3))
  }

  func configure(with title: String) {

  }
}
