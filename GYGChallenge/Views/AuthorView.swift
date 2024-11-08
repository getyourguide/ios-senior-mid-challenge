//
// Copyright © 2024 GetYourGuide. All rights reserved.
//

import SwiftUI

struct AuthorView: View {
    let authorInfo: AuthorInfo?
    let reviewID: Int

    private let reviewLabel: String
    private let authorImage: UIImage?

    init(authorInfo: AuthorInfo?, reviewID: Int) {
        self.authorInfo = authorInfo
        self.reviewID = reviewID

        var reviewedByContentText = authorInfo?.fullName ?? "Anonymous"
        if let country = authorInfo?.country {
            reviewedByContentText = "\(reviewedByContentText) - \(country)"
        }
        self.reviewLabel = reviewedByContentText

        if
            let photo = authorInfo?.photo(reviewID: reviewID),
            let data = try? Data(contentsOf: URL(string: photo)!)
        {
            self.authorImage = UIImage(data: data)
        } else {
            self.authorImage = nil
        }
    }

    var body: some View {
        HStack(spacing: 10) {
            if let authorImage {
                Image(uiImage: authorImage)
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("reviewed by")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(reviewLabel)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    AuthorView(
        authorInfo: .init(
            fullName: "Max Mustermann",
            country: "Germany"
        ),
        reviewID: 1
    )
    AuthorView(
        authorInfo: .init(
            fullName: "John Doe",
            country: "United Kingdom"
        ),
        reviewID: 2
    )
}
