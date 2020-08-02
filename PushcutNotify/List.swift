//
//  List.swift
//  PushcutNotify
//
//  Created by royal on 02/08/2020.
//

import Foundation
import ArgumentParser

/// Sets the endpoint URL.
struct List: ParsableCommand {
	public static let configuration = CommandConfiguration(abstract: "Shows all of the endpoint URLs.")
	
	func run() throws {
		let dictionary: [String: Any] = UserDefaults.standard.dictionary(forKey: "Endpoints") ?? [:]
		dictionary.forEach { key, value in
			print("\"\(key)\": \(value)")
		}
		
		List.exit()
	}
}
