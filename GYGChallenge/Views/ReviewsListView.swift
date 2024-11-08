//
//  ReviewsListView.swift
//  GYGChallenge
//
//  Created by Joseph El Mallah on 28.10.2024.
//

import SwiftUI

public struct ReviewsListView: View {
    var reviews: [Review]

    let lastRowHasAppeared: () -> Void

    public var body: some View {
        List(reviews, id: \.activityId) { review in
            ReviewView(review: review)
                .onAppear {
                    // If it's the last row, execute the block.
                    if reviews.last?.id == review.id {
                        lastRowHasAppeared()
                    }
                }
        }
    }
}
