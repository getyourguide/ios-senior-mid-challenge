//
// Copyright © 2024 GetYourGuide. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let activityId: Int = 251502

    var reviews: [Review] = []
    var networkClient: NetworkClient = {
        let networkClient = NetworkClient()

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        networkClient.jsonDecoder = jsonDecoder

        return networkClient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reviews for Activity ID \(activityId)"

        fetchReviews()
    }

    func fetchReviews() {
        let url = URL(
            string: "https://travelers-api.getyourguide.com/activities/\(activityId)/reviews?offset=\(reviews.count)"
        )!

        _ = networkClient.run(
            URLRequest(url: url)
        ) { (result: Result<ReviewsResponse, NetworkError>) in
            switch result {
            case let.success(response):
                self.reviews.append(contentsOf: response.reviews)
                // Due to a bug in the API, duplicated reviews can be returned.
                self.reviews = self.reviews.uniqued()
            case let .failure(error):
                print(error)
            }

            self.addReviewsViewController()
        }
    }

    func addReviewsViewController() {
        let hostingController = UIHostingController(
            rootView: ReviewsListView(
                reviews: reviews,
                lastRowHasAppeared: { [weak self] in
                    self?.fetchReviews()
                }
            )
        )

        addChild(hostingController)
        if let view = viewIfLoaded {
            view.addSubview(hostingController.view)
            hostingController.view.frame = view.bounds
            hostingController.view.pinEdges(to: view)
        }

        hostingController.didMove(toParent: self)
    }
}
