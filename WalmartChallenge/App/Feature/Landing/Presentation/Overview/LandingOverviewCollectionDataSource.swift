import UIKit

final class LandingOverviewCollectionDataSource: NSObject {
  private weak var view: LandingOverviewViewProtocol?

  func set(_ view: LandingOverviewViewProtocol) {
    self.view = view
  }
}

// MARK: - UICollectionViewDataSource

extension LandingOverviewCollectionDataSource: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    guard let _ = view?.model else { return .zero }
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let model = view?.model else { return .zero }
    return section == .zero
      ? 1
      : model.products.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    prepareProductCollectionViewCell(for: collectionView, at: indexPath)
  }
}

extension LandingOverviewCollectionDataSource {
  @MainActor
  private func prepareProductCollectionViewCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
    guard let model = view?.model else { return UICollectionViewCell() }
    let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    if indexPath.section == .zero {
      cell.configure(.init(image: model.featuredProduct.imageData,
                           title: model.featuredProduct.title,
                           subtitle: model.featuredProduct.price,
                           headline: "Featured",
                           handler: .init(
                            handler: { [weak self] _ in
                              self?.view?.addToCart(model.featuredProduct)
                            })
                          )
                     )
    } else {
      cell.configure(.init(image: model.products[indexPath.row].imageData,
                           title: model.products[indexPath.row].title,
                           subtitle: model.products[indexPath.row].price,
                           handler: .init(
                            handler: { [weak self] _ in
                              self?.view?.addToCart(model.products[indexPath.row])
                            })
                          )
                     )
    }
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    return cell
  }
}
