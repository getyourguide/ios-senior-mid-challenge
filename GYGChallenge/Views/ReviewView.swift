//
// Copyright © 2024 GetYourGuide. All rights reserved.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    
    private let formattedDate: String?
    
    init(review: Review) {
        self.review = review
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        formattedDate = review.created.map(dateFormatter.string(from:))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let formattedDate {
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            RatingView(ratingValue: review.rating)
            if let reviewMessage = review.message {
                Text(reviewMessage)
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            AuthorView(
                authorInfo: review.author,
                reviewID: review.id
            )
        }
    }
}

#Preview {
    ReviewView(
        review: .init(
            activityId: 2,
            id: 2,
            author: .init(
                fullName: "Sir Pounce",
                country: "United Kingdom"
            ),
            created: .now,
            enjoyment: nil,
            message: "Monica was an excellent guide. She was very knowledgeable and patient. I would highly recommend her for any hiking trip.",
            rating: 4
        )
    )
    ReviewView(
        review: .init(
            activityId: 1,
            id: 1,
            author: .init(
                fullName: "Object Ivcy",
                country: "United States"
            ),
            created: .now,
            enjoyment: nil,
            message: "Alfonso took us on an amazing hike. Eventhough my kids were a little scared, they were very excited to see the beautiful scenery. I would highly recommend him for any hiking trip.",
            rating: 4
        )
    )
}
