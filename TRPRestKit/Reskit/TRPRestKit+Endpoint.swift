//
//  TRPRestKit+Endpoint.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

extension TRPRestKit {

    /// Called on the kit's queue with the `data` of the response envelope, which is nil when
    /// the api sends none. These calls only send and decode: they never store a token.
    public typealias ResultHandler<T> = (Result<T?, Error>) -> Void

    internal func send<T: Decodable>(_ endpoint: TRPEndpoint, completion: @escaping ResultHandler<T>) {
        let service = TRPEndpointService<T>(endpoint: endpoint)
        service.completion = { result, error, _ in
            let outcome: Result<T?, Error>
            if let error = error {
                outcome = .failure(error)
            } else if let envelope = result as? TRPGenericParser<T> {
                outcome = .success(envelope.data)
            } else {
                outcome = .failure(TRPErrors.emptyDataOrParserError)
            }
            self.queue.async {
                completion(outcome)
            }
        }
        service.connection()
    }
}
