//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/05/2022.
//

import SwiftUI

struct EditCardsView: View {
	/// Environment Property to 'dismiss' View
	@Environment(\.dismiss) var dismiss
	
	/// State Property of an Array of 'Card' Object ("Card Stack")
	@State private var cards = [Card]()
	
	/// State Property to store new Card prompt & answer 'String' values
	@State private var newPrompt = ""
	@State private var newAnswer = ""
	
    var body: some View {
		NavigationView {
			List {
				/// Section to add New Card
				Section("Add New Card") {
					TextField("Prompt", text: $newPrompt)
					TextField("Answer", text: $newAnswer)
					/// "Add" Button HStack
					HStack {
						Spacer()
						Button("Add Card", action: addCard)
						Spacer()
					}
				}
				
				/// Section to show Cards in the existing 'cards' "Card Stack"
				Section {
					ForEach(0..<cards.count, id: \.self) { index in
						VStack(alignment: .leading) {
							Text(cards[index].prompt)
								.font(.headline)
							
							Text(cards[index].answer)
								.foregroundColor(.secondary)
						}
					}
					/// Add "Swipe to Delete" function by calling 'removeCard' Method
					.onDelete(perform: removeCard)
				}
			}
			.navigationTitle("Edit Card Stack")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("Done", action: done)
				}
			}
			.listStyle(.grouped)
			/// Attempt to load saved "Card Stack" Data from 'UserDefaults' by calling 'loadData' Method
			.onAppear(perform: loadData)
		}
    }
	
	/// Method to dismiss 'EditCardView'
	func done() {
		dismiss()
	}
	
	/// Method to load saved "Card Stack" JSON Data from 'UserDefaults'
	func loadData() {
		if let data = UserDefaults.standard.data(forKey: "Card Stack") {
			if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
				cards = decoded
			}
		}
	}
	
	/// Method to save "Card Stack" Data as JSON Data to 'UserDefaults'
	func saveData() {
		if let data = try? JSONEncoder().encode(cards) {
			UserDefaults.standard.set(data, forKey: "Card Stack")
		}
	}
	
	/// Method to prepare & add new 'Card' Object to the 'cards' "Card Stack"
	func addCard() {
		let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
		let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
		
		guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
		
		let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
		cards.insert(card, at: 0)
		
		/// Save changes
		saveData()
		
		/// Reset TextFields
		newPrompt = ""
		newAnswer = ""
	}
	
	/// Method to remove 'Card' Object from the 'cards' "Card Stack"
	func removeCard(at offsets: IndexSet) {
		cards.remove(atOffsets: offsets)
		
		/// Save changes
		saveData()
	}
}



struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
