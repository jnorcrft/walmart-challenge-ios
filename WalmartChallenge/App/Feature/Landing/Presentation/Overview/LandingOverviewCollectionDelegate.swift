import UIKit

final class LandingOverviewCollectionDelegate: NSObject {
  private weak var view: LandingOverviewViewProtocol?

  func set(_ view: LandingOverviewViewProtocol) {
    self.view = view
  }
}

// MARK: - UICollectionViewDelegate

extension LandingOverviewCollectionDelegate: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let product = indexPath.section == .zero
        ? view?.model?.featuredProduct
        : view?.model?.products[indexPath.row]
    {
      view?.showProductDetail(product)
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LandingOverviewCollectionDelegate: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let contentInset = collectionView.contentInset
    let sectionInset = layout.sectionInset
    let totalWidth = collectionView.bounds.width - contentInset.left - contentInset.right - sectionInset.left - sectionInset.right

    if indexPath.section == .zero {
      // Featured product - full width
      return CGSize(width: totalWidth, height: 200)
    } else {
      // Regular products - 2 columns
      let spacing = layout.minimumInteritemSpacing
      let itemWidth = (totalWidth - spacing) / 2
      return CGSize(width: itemWidth, height: itemWidth * 1.4)
    }
  }
}
