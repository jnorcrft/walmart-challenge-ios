import UIKit

final class LandingCategoriesViewController: UITableViewController {
  // MARK: - Properties

  private let categories: [String]
  private weak var coordinator: LandingCoordinating?

  // MARK: - Initializer & Lifecycle Methods

  init(categories: [String], coordinator: LandingCoordinating) {
    var categoriesCopy = categories
    categoriesCopy.insert("All", at: .zero)
    self.categories = categoriesCopy
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
  }

  // MARK: - Private Methods

  private func prepareTableView() {
    tableView.register(UITableViewCell.self)
    tableView.tableHeaderView = TableHeaderView(
      frame: .init(x: .zero, y: .zero, width: view.frame.width, height: 60),
      text: "Categories"
    ).autolayout()
  }
}

// MARK: - UITableViewDataSource

extension LandingCategoriesViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = categories[indexPath.row]
    cell.contentConfiguration = contentConfiguration

    return cell
  }
}

// MARK: - UITableViewDelegate

extension LandingCategoriesViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedCategory = categories[indexPath.row]
    coordinator?.didSelectCategory(selectedCategory)
    dismiss(animated: true)
  }
}
