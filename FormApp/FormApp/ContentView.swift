//
//  ContentView.swift
//  FormApp
//
//  Created by Lucas Neves dos santos pompeu on 08/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var feedback: String = ""
    @State var nota: Float = 5
    @State var isPresentedAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.gray)
                        TextField("Nome", text: $name)
                    }
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundStyle(.gray)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                } header: {
                    Text("Informações pessoais")
                }
                
                Section {
                    ZStack {
                        if feedback.isEmpty { 
                            Text("Digite seu feedback aqui")
                                .foregroundStyle(.gray)
                        }
                        TextEditor(text: $feedback)
                    }
                    .frame(height: 60)
                } header: {
                    Text("Informe seu feedback")
                }
                
                Section {
                    HStack {
                        Text("1")
                        Slider(value: $nota, in: 1...10, step: 1)
                        Text("10")
                        Spacer().frame(width: 30)
                        Text("Nota: \(Int(nota))")
                    }
                } header: {
                    Text("Nota")
                }
                
                Section {
                    Button {
                        print("tapped button")
                        isPresentedAlert.toggle()
                    } label: {
                        Text("Enviar Feedback")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .foregroundStyle(.white)
                            .background(isDisabledButton ? Color.gray : Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .disabled(isDisabledButton)
                }
            }
        }
        .navigationTitle("Feedback")
        .navigationBarTitleDisplayMode(.large)
        .alert("Enviar Feedback", isPresented: $isPresentedAlert) {
            Button {
                print("Botão enviar")
                clearAll()
            } label: {
                Text("Enviar")
            }
        } message: {
            Text(messageDescription)
        }
    }
    
    var messageDescription: String {
        if feedback.isEmpty {
            return "Nome: \(name)\nEmail: \(email)\nNota: \(Int(nota))"
        } else {
            return "Nome: \(name)\nEmail: \(email)\nFeedback: \(feedback)\nNota: \(Int(nota))"
        }
    }
    
    var isDisabledButton: Bool {
        return name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func clearAll() {
        feedback = ""
        name = ""
        email = ""
        nota = 5
    }
}

#Preview {
    ContentView()
}
