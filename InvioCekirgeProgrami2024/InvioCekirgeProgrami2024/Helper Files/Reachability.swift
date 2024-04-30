//
//  Reachability.swift
//  InvioCekirgeProgrami2024
//
//  Created by Berat Ridvan Asilturk on 30.04.2024.
//

import SystemConfiguration

final class Reachability: NSObject {

    private var connection: SCNetworkReachability?

    override init() {
        super.init()

        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout.size(ofValue: address))
        address.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            connection = nil
            return
        }
        connection = defaultRouteReachability
    }
    
    func isConnectedToNetwork() -> Bool {
        guard let reachability = try? Reachability() else { return false }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability.connection!, &flags) { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}


