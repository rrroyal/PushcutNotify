//
//  SetURL.swift
//  notify
//
//  Created by royal on 02/08/2020.
//

import Foundation
import ArgumentParser

/// Sets the endpoint URL.
struct SetURL: ParsableCommand {
	public static let configuration = CommandConfiguration(abstract: "Sets the endpoint URL.")
	
	@Argument(help: "Endpoint URL")
	private var url: String?
	
	func run() throws {
		
		if let url: String = url {
			if let url: URL = URL(string: url) {
				UserDefaults.standard.set(url, forKey: "EndpointURL")
				print("Endpoint URL has been set to \"\(url)\"!")
			}
		} else {
			UserDefaults.standard.removeObject(forKey: "EndpointURL")
			print("Endpoint URL has been removed!")
		}
		SetURL.exit()
	}
}
