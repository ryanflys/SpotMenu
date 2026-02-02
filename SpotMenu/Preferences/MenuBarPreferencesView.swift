import SwiftUI

struct MenuBarPreferencesView: View {
    @ObservedObject var model: MenuBarPreferencesModel
    @ObservedObject var playbackModel: PlaybackModel
    @ObservedObject var musicPlayerPreferencesModel: MusicPlayerPreferencesModel
    @State private var isSpotifyAuthenticated = false

    @StateObject private var previewModel: StatusItemModel = {
        let model = StatusItemModel()
        model.artist = "Lorem Ipsum"
        model.title = "Ut Sit Amet Justo Efficitur, Imperdiet Elit Sit Amet"
        model.isPlaying = true
        model.isLiked = true
        return model
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        Toggle(NSLocalizedString("menuBar.displayArtist", comment: ""), isOn: Binding(
                            get: { model.showArtist },
                            set: { newValue in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    model.showArtist = newValue
                                }
                            }
                        ))

                        if model.showArtist {
                            Toggle(NSLocalizedString("menuBar.hideArtistWhenPaused", comment: ""), isOn: $model.hideArtistWhenPaused)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                        }

                        Toggle(NSLocalizedString("menuBar.displayTitle", comment: ""), isOn: Binding(
                            get: { model.showTitle },
                            set: { newValue in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    model.showTitle = newValue
                                }
                            }
                        ))

                        if model.showTitle {
                            Picker(
                                NSLocalizedString("menuBar.longFormContent", comment: ""),
                                selection: $musicPlayerPreferencesModel
                                    .longFormTitleStyle
                            ) {
                                ForEach(
                                    LongFormTitleStyle.allCases,
                                    id: \.self
                                ) { style in
                                    Text(style.displayName).tag(style)
                                }
                            }
                            .transition(.opacity.combined(with: .move(edge: .top)))
                            
                            Toggle(NSLocalizedString("menuBar.hideTitleWhenPaused", comment: ""), isOn: $model.hideTitleWhenPaused)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    } header: {
                        Text(NSLocalizedString("menuBar.textDisplay", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("menuBar.textDisplay.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        Toggle(NSLocalizedString("menuBar.showPlayingIcon", comment: ""), isOn: $model.showIsPlayingIcon)

                        if playbackModel.isLikingImplemented
                            && musicPlayerPreferencesModel.likingEnabled
                        {
                            Toggle(NSLocalizedString("menuBar.showLikedIcon", comment: ""), isOn: Binding(
                                get: { model.showIsLikedIcon },
                                set: { newValue in
                                    model.showIsLikedIcon = newValue
                                    if newValue && !isSpotifyAuthenticated {
                                        LoginWindowManager.showLoginWindow(
                                            with: musicPlayerPreferencesModel
                                        )
                                    }
                                }
                            ))
                        }

                        Toggle(NSLocalizedString("menuBar.displayAppIcon", comment: ""), isOn: Binding(
                            get: { model.showAppIcon },
                            set: { newValue in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    model.showAppIcon = newValue
                                }
                            }
                        ))
                    } header: {
                        Text(NSLocalizedString("menuBar.icons", comment: ""))
                    } footer: {
                        if !model.showAppIcon {
                            Text(
                                NSLocalizedString("menuBar.icons.fallback", comment: "")
                            )
                        } else {
                            Text(NSLocalizedString("menuBar.icons.footer", comment: ""))
                        }
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        Toggle(NSLocalizedString("menuBar.compactView", comment: ""), isOn: $model.compactView)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(NSLocalizedString("menuBar.maxWidth", comment: ""))
                                Spacer()
                                Text("\(Int(model.maxStatusItemWidth)) pt")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            Slider(
                                value: $model.maxStatusItemWidth,
                                in: 40...300,
                                step: 1
                            )
                        }
                    } header: {
                        Text(NSLocalizedString("menuBar.layout", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("menuBar.layout.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        if model.compactView {
                            Picker(NSLocalizedString("menuBar.fontWeight.topRow", comment: ""), selection: $model.fontWeightCompactTop) {
                                ForEach(MenuBarFontWeight.allCases, id: \.self) { weight in
                                    Text(weight.rawValue.capitalized).tag(weight)
                                }
                            }

                            Picker(NSLocalizedString("menuBar.fontWeight.bottomRow", comment: ""), selection: $model.fontWeightCompactBottom) {
                                ForEach(MenuBarFontWeight.allCases, id: \.self) { weight in
                                    Text(weight.rawValue.capitalized).tag(weight)
                                }
                            }
                        } else {
                            Picker(NSLocalizedString("menuBar.fontWeight", comment: ""), selection: $model.fontWeightNormal) {
                                ForEach(MenuBarFontWeight.allCases, id: \.self) { weight in
                                    Text(weight.rawValue.capitalized).tag(weight)
                                }
                            }
                        }
                    } header: {
                        Text(NSLocalizedString("menuBar.fontWeights", comment: ""))
                    } footer: {
                        if model.compactView {
                            Text(NSLocalizedString("menuBar.fontWeights.footer.compact", comment: ""))
                        } else {
                            Text(NSLocalizedString("menuBar.fontWeights.footer.normal", comment: ""))
                        }
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        VStack(spacing: 8) {
                            StatusItemView(
                                model: previewModel,
                                menuBarPreferencesModel: model,
                                musicPlayerPreferencesModel: musicPlayerPreferencesModel,
                                playbackModel: playbackModel
                            )
                            .frame(width: model.maxStatusItemWidth, height: 22)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                    .foregroundColor(.gray.opacity(0.4))
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } header: {
                        Text(NSLocalizedString("menuBar.preview", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("menuBar.preview.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
        .frame(maxWidth: 600)
        .padding(20)
    }
        .onAppear {
            SpotifyAuthManager.shared.checkAuthenticationStatus {
                self.isSpotifyAuthenticated = $0
            }
        }
    }
}

#Preview {
    MenuBarPreferencesView(
        model: MenuBarPreferencesModel(),
        playbackModel: PlaybackModel(
            preferences: MusicPlayerPreferencesModel()
        ),
        musicPlayerPreferencesModel: MusicPlayerPreferencesModel()
    )
}
