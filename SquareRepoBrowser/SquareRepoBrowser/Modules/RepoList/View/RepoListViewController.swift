//
//  RepoListViewController.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import UIKit

/// Displays a list of GitHub repositories for the Square organization.
final class RepoListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var repoTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noDataFoundLabel: UILabel!

    // MARK: - Properties
    private let repoListViewModel = RepoListViewModel()
    private var repoList: [Repository] = []
    private let refreshControl = UIRefreshControl()
}

// MARK: - Lifecycle
extension RepoListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        observeViewModel()

        // Initial API call
        fetchRepositories()
    }
}

// MARK: - Setup Methods
extension RepoListViewController {

    /// Configures table view UI, delegates, cell registration, and refresh control
    private func setupTableView() {
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.estimatedRowHeight = 100
        repoTableView.dataSource = self
        repoTableView.delegate = self
        repoTableView.tableFooterView = UIView() // Removes empty separators

        setupRefreshControl()
        registerTableViewCell()
    }

    /// Configures pull-to-refresh for the table view
    private func setupRefreshControl() {
        refreshControl.addTarget(
            self,
            action: #selector(handlePullToRefresh),
            for: .valueChanged
        )
        repoTableView.refreshControl = refreshControl
    }

    /// Registers custom table view cell
    private func registerTableViewCell() {
        repoTableView.register(
            UINib(nibName: RepoListTableViewCell.Reuse.nibName, bundle: nil),
            forCellReuseIdentifier: RepoListTableViewCell.Reuse.identifier
        )
    }
}

// MARK: - API Calls
extension RepoListViewController {

    /// Triggers repository fetch via ViewModel
    private func fetchRepositories() {
        repoListViewModel.fetchRepositories()
    }
}

// MARK: - ViewModel Observation
extension RepoListViewController {

    /// Observes ViewModel state changes and updates UI accordingly
    private func observeViewModel() {
        repoListViewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch state {

                case .loading:
                    self.setLoading(true)
                    self.showMessage(nil)

                case .success(let repos):
                    self.setLoading(false)
                    self.repoList = repos
                    self.showMessage(repos.isEmpty ? AppConstants.Messages.noRepositoriesFound : nil)
                    self.repoTableView.reloadData()

                case .failure(let message):
                    self.setLoading(false)
                    self.showMessage(message)
                }
            }
        }
    }
}

// MARK: - UI State Helpers
extension RepoListViewController {

    /// Shows or hides loading indicators
    private func setLoading(_ isLoading: Bool) {
        isLoading
        ? activityIndicator.startAnimating()
        : activityIndicator.stopAnimating()

        if !isLoading {
            refreshControl.endRefreshing()
        }
    }

    /// Displays error or empty state message
    private func showMessage(_ text: String?) {
        noDataFoundLabel.text = text
        let shouldShowMessage = (text != nil)

        noDataFoundLabel.isHidden = !shouldShowMessage
        repoTableView.isHidden = shouldShowMessage
    }
}

// MARK: - User Actions
extension RepoListViewController {

    /// Triggered when user pulls to refresh
    @objc private func handlePullToRefresh() {
        guard Reachability.shared.isConnected else {
                setLoading(false)
                showMessage(AppConstants.Messages.noInternetConnection)
                return
            }

            fetchRepositories()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate Methods
extension RepoListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        repoList.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RepoListTableViewCell.Reuse.identifier,
            for: indexPath
        ) as? RepoListTableViewCell else {
            return UITableViewCell()
        }
        if repoList.count > 0 {
            cell.configure(with: repoList[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if repoList.count > 0 {
            let repo = repoList[indexPath.row]
            
            // Open the selected repository in Safari
            guard
                let urlString = repo.htmlURL,
                let url = URL(string: urlString)
            else { return }
            
            UIApplication.shared.open(url)
        }
    }
}
