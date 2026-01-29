//
//  Repository+Test.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

@testable import SquareRepoBrowser
import Foundation

extension Repository {

    static func mock(
        id: Int = 1,
        name: String = "square-test",
        description: String? = "Test repo",
        htmlURL: String? = "https://github.com/square/test",
        isFork: Bool = false,
        starsCount: Int = 10,
        language: String? = "Swift",
        updatedAt: String = "2026-01-01"
    ) -> Repository {
        return Repository(
            id: id,
            name: name,
            description: description,
            htmlURL: htmlURL,
            isFork: isFork,
            starsCount: starsCount,
            language: language,
            updatedAt: updatedAt
        )
    }
}
