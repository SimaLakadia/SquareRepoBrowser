//
//  RepoListTableViewCell.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//


import UIKit

/// Displays a GitHub repository name and description
final class RepoListTableViewCell: UITableViewCell {

    // MARK: - Reuse
    struct Reuse {
        static let identifier = "RepoListTableViewCell"
        static let nibName = "RepoListTableViewCell"
    }

    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none // Disable selection highlight
    }

    // MARK: - Configuration
    func configure(with repo: Repository) {
        nameLabel.text = repo.name.capitalizedFirstLetter()
        descriptionLabel.text = repo.description?.capitalizedFirstLetter() ?? ""
    }
}

