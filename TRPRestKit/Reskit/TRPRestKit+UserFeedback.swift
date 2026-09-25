//
//  TRPRestKit+UserFeedback.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Feedback
extension TRPRestKit {

    /// The subjects a feedback can be about, split into app-wide and poi ones.
    public func feedbackSubjects(completion: @escaping ResultHandler<TRPFeedbackInfoModel>) {
        send(.feedbackSubjects, completion: completion)
    }

    /// The user's feedbacks with the replies they received.
    public func userFeedbacks(completion: @escaping ResultHandler<[TRPUserFeedbackInfoModel]>) {
        send(.userFeedbacks, completion: completion)
    }

    public func sendFeedback(_ request: TRPFeedbackRequestModel, completion: @escaping ResultHandler<TRPCreateResultModel>) {
        send(.sendFeedback(request), completion: completion)
    }

    public func markFeedbackRead(feedbackId: String, completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.markFeedbackRead(feedbackId: feedbackId), completion: completion)
    }

    public func replyFeedback(feedbackId: String,
                              reply: String,
                              completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.replyFeedback(feedbackId: feedbackId, reply: reply), completion: completion)
    }
}
