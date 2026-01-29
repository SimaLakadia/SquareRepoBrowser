//
//  Reachability.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

import Foundation
import Network

/// Monitors network connectivity using Apple's NWPathMonitor.
/// Intended for UI hints (e.g. showing offline banners),
/// not for blocking API requests.
final class Reachability {

    // MARK: - Singleton

    /// Shared instance used throughout the app
    static let shared = Reachability()

    // MARK: - Properties

    /// System network path monitor
    private let monitor = NWPathMonitor()

    /// Background queue used for monitoring network changes
    private let monitorQueue = DispatchQueue(label: AppConstants.Reachability.monitorQueueLabel)

    /// Indicates current internet availability
    /// This value updates asynchronously
    private(set) var isConnected: Bool = false

    // MARK: - Initializer

    /// Private initializer to enforce singleton usage
    private init() {
        startMonitoring()
    }

    // MARK: - Monitoring

    /// Starts listening for network connectivity changes.
    /// Updates `isConnected` whenever the network status changes.
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: monitorQueue)
    }

    /// Stops monitoring network changes.
    /// Call when monitoring is no longer required.
    func stopMonitoring() {
        monitor.cancel()
    }

    /// Performs a one-time internet availability check.
    /// Use for UI decisions only, not for gating API calls.
    /// - Parameter completion: Returns true if internet is available.
    func checkConnection(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            completion(path.status == .satisfied)
            self.monitor.cancel()
        }
        monitor.start(queue: monitorQueue)
    }
}
