//
//  main.swift
//  notify
//
//  Created by royal on 02/08/2020.
//

import Foundation
import ArgumentParser

enum AppError: Error, LocalizedError {
	case unknown
	case noEndpointURL
	case encodingError
	case error(reason: String)
	
	public var errorDescription: String {
		switch self {
			case .unknown:				return "Unknown error"
			case .noEndpointURL:		return "No endpoint URL!"
			case .encodingError:		return "Error encoding body!"
			case .error(let reason):	return reason
		}
	}
}

struct PushcutNotify: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "Send Pushcut notifications.",
		subcommands: [
			Send.self,
			SetURL.self,
			List.self
		])
	
	init() { }
}

PushcutNotify.main()
RunLoop.main.run()
