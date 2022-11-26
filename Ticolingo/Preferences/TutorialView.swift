//
//  TutorialView.swift
//  Ticolingo
//
//  Created by Kai Quan Tay on 26/11/22.
//

import SwiftUI

struct TutorialView: View {
    @Binding
    var showThisView: Bool

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    GroupBox {
                        Text("What are study groups?")
                            .font(.system(.title3))
                        Text("Groups of study sets")
                            .font(.system(.subheadline))
                        Image("whatarestudygroups")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("What are study sets?")
                            .font(.system(.title3))
                        Text("Groups of vocabulary")
                            .font(.system(.subheadline))
                        Image("whatarestudysets")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("What are vocabulary?")
                            .font(.system(.title3))
                        Text("A chinese word with PinYin, Definitions, Examples, Difficulty and Familiarity")
                            .font(.system(.subheadline))
                        Image("whatarevocabulary")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("How do I play the games?")
                            .font(.system(.title3))
                        Text("Tap on the game you want to play")
                            .font(.system(.subheadline))
                        Image("howtoplaythegame")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("How do I add new study groups/sets/vocabulary?")
                            .font(.system(.title3))
                        Text("Click the edit button and follow the instructions")
                            .font(.system(.subheadline))
                        Image("howtoaddstuff")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("How do I reset my vocabulary?")
                            .font(.system(.title3))
                        Text("Go to preferences and press reset")
                            .font(.system(.subheadline))
                        Image("howtoresetvocab")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }
                    
                    GroupBox {
                        Text("How do I change the app's appearance?")
                            .font(.system(.title3))
                        Text("Go to preferences and choose a theme")
                            .font(.system(.subheadline))
                        Image("howtochangecolor")
                            .resizable()
                            .scaledToFit()
                        Divider()
                    }

                    GroupBox {
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Finish") {
                                showThisView = false
                            }
                            Spacer()
                        }
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(showThisView: .constant(true))
    }
}
