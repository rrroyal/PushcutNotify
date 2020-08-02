//
//  SetURL.swift
//  notify
//
//  Created by royal on 02/08/2020.
//

import Foundation
import ArgumentParser

/// Sets the endpoint URLs.
struct SetURL: ParsableCommand {
	public static let configuration = CommandConfiguration(abstract: "Sets the endpoint URLs.")
	
	@Argument(help: "Name")
	private var name: String
	
	@Argument(help: "Endpoint URL")
	private var url: String?
	
	func run() throws {
		var dictionary: [String: Any] = UserDefaults.standard.dictionary(forKey: "Endpoints") ?? [:]
		
		if let url: String = url {
			dictionary[name] = url
			print(dictionary)
			print("Endpoint URL with name \"\(name)\" has been set to \"\(url)\"!")
		} else {
			dictionary[name] = nil
			print("Removed endpoint with name \"\(name)\".")
		}
		
		UserDefaults.standard.set(dictionary, forKey: "Endpoints")
		SetURL.exit()
	}
}
