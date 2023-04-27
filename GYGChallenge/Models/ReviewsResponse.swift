//
// Copyright © 2021 GetYourGuide. All rights reserved.
//

import Foundation

struct ReviewsResponse: Codable {
    var averageRating: Float
    var pagination: Pagination?
    var reviews: [Review]
    var totalCount: Int
}

struct Review: Codable, Equatable {
    var activityId: Int
    var id: Int
    var author: AuthorInfo?
    var created: Date?
    var enjoyment: String?
    var message: String?
    var rating: Int
}

struct AuthorInfo: Codable, Equatable {
    var fullName: String
    var country: String?
}

extension AuthorInfo {
    func photo(reviewID: Int) -> String? {
        reviewID % 2 == 0
        ? "https://loremflickr.com/300/300?lock=\(reviewID)"
        : nil
    }
}

struct Pagination: Codable, Equatable {
    var limit: Int?
    var offset: Int?
}
