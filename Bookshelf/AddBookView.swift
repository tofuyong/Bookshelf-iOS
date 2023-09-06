//
//  AddBookView.swift
//  Bookshelf
//
//  Created by Andrea Yong on 6/9/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Classics"
    @State private var review = ""
    
    let genres = ["Classics", "Fantasy", "Horror", "Mystery", "Thriller", "Kids", "Poetry", "Biography", "Romance", "SciFi"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title.trimmingCharacters(in: .whitespaces)
                        newBook.author = author.trimmingCharacters(in: .whitespaces)
                        newBook.rating = Int16(rating)
                        newBook.genre = genre.trimmingCharacters(in: .whitespaces)
                        newBook.review = review.trimmingCharacters(in: .whitespaces)
                        newBook.dateAdded = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty == true || author.trimmingCharacters(in: .whitespaces).isEmpty == true || genre.trimmingCharacters(in: .whitespaces).isEmpty == true)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
