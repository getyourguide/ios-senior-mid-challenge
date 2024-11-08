//
// Copyright © 2024 GetYourGuide. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    let ratingValue: Int
    let maxRating: Int = 5
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...maxRating, id: \.self) {
                Image(uiImage: $0 <= ratingValue ? .iconStarYellow! : .iconStarGray!)
            }
        }
    }
}

#Preview {
    RatingView(ratingValue: 0)
    RatingView(ratingValue: 2)
    RatingView(ratingValue: 5)
}
