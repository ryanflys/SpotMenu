import SwiftUI

struct MusicPlayerPreferencesView: View {
    @ObservedObject var model: MusicPlayerPreferencesModel
    @ObservedObject var playbackModel: PlaybackModel
    @ObservedObject var spotifyAuthManager = SpotifyAuthManager.shared

    @State private var isTestingSpotifyConnection = false
    @State private var spotifyConnectionTestResult: Bool?
    @State private var showSpotifyConnectionTestResult = false
    @State private var isSpotifyAuthenticated = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        Picker(NSLocalizedString("player.preferredPlayer", comment: ""), selection: $model.preferredMusicApp) {
                            ForEach(PreferredPlayer.allCases) { player in
                                Text(player.displayName).tag(player)
                            }
                        }
                    } header: {
                        Text(NSLocalizedString("player.musicPlayer", comment: ""))
                    } footer: {
                        Text(
                            NSLocalizedString("player.musicPlayer.footer", comment: "")
                        )
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                if playbackModel.isLikingImplemented {
                    Form {
                        Section {
                            Toggle(NSLocalizedString("player.enableTrackLiking", comment: ""), isOn: $model.likingEnabled)
                                .onChange(of: model.likingEnabled) { newValue in
                                    if newValue && !isSpotifyAuthenticated {
                                        LoginWindowManager.showLoginWindow(with: model)
                                    }
                                }

                            if model.likingEnabled {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(NSLocalizedString("player.spotifyClientID", comment: ""))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    TextField(
                                        NSLocalizedString("player.enterSpotifyClientID", comment: ""),
                                        text: Binding(
                                            get: { model.spotifyClientID ?? "" },
                                            set: { newValue in
                                                let trimmed = newValue.trimmingCharacters(
                                                    in: .whitespacesAndNewlines
                                                )
                                                model.spotifyClientID =
                                                    trimmed.isEmpty ? nil : trimmed
                                            }
                                        )
                                    )
                                    .textFieldStyle(.roundedBorder)
                                }

                                HStack {
                                    if showSpotifyConnectionTestResult {
                                        HStack(spacing: 6) {
                                            if isTestingSpotifyConnection {
                                                ProgressView()
                                                    .scaleEffect(0.5)
                                                Text(NSLocalizedString("player.testing", comment: ""))
                                            } else {
                                                Image(systemName: connectionStatusIcon)
                                                Text(connectionStatusText)
                                            }
                                        }
                                        .foregroundColor(connectionStatusColor)
                                        .font(.caption)
                                    }

                                    Spacer()

                                    Button(NSLocalizedString("player.testConnection", comment: "")) {
                                        testConnection()
                                    }
                                    .disabled(isTestingSpotifyConnection)

                                    if !isSpotifyAuthenticated {
                                        Button(NSLocalizedString("player.logInToSpotify", comment: "")) {
                                            LoginWindowManager.showLoginWindow(with: model)
                                        }
                                    }
                                }
                                .padding(.top, 8)
                            }
                        } header: {
                            Text(NSLocalizedString("player.spotifyIntegration", comment: ""))
                        } footer: {
                            Text(NSLocalizedString("player.spotifyIntegration.footer", comment: ""))
                        }
                    }
                    .formStyle(.grouped)
                    .scrollContentBackground(.hidden)
                }
            }
        .frame(maxWidth: 600)
        .padding(20)
    }
        .onAppear {
            SpotifyAuthManager.shared.checkAuthenticationStatus { isAuthed in
                DispatchQueue.main.async {
                    isSpotifyAuthenticated = isAuthed
                    spotifyConnectionTestResult = isAuthed
                    showSpotifyConnectionTestResult = true
                }
            }
        }
        .onChange(of: spotifyAuthManager.didAuthenticate) { newValue in
            if newValue {
                isSpotifyAuthenticated = true
                spotifyConnectionTestResult = true
                showSpotifyConnectionTestResult = true
            }
        }
    }

    private func testConnection() {
        isTestingSpotifyConnection = true
        spotifyConnectionTestResult = nil
        showSpotifyConnectionTestResult = true
        let start = Date()

        SpotifyAuthManager.shared.getAccessToken { token in
            let elapsed = Date().timeIntervalSince(start)
            let delay = max(0.5 - elapsed, 0)

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let isAuthed = token != nil
                self.spotifyConnectionTestResult = isAuthed
                self.isSpotifyAuthenticated = isAuthed
                self.isTestingSpotifyConnection = false
            }
        }
    }

    private var connectionStatusText: String {
        if isTestingSpotifyConnection {
            return NSLocalizedString("player.testing", comment: "")
        } else if let result = spotifyConnectionTestResult {
            return result ? NSLocalizedString("player.connected", comment: "") : NSLocalizedString("player.notConnected", comment: "")
        } else {
            return NSLocalizedString("player.unknown", comment: "")
        }
    }

    private var connectionStatusIcon: String {
        if isTestingSpotifyConnection {
            return "hourglass"
        } else if let result = spotifyConnectionTestResult {
            return result ? "checkmark.circle.fill" : "xmark.circle.fill"
        } else {
            return "questionmark.circle"
        }
    }

    private var connectionStatusColor: Color {
        if isTestingSpotifyConnection {
            return .gray
        }
        if let result = spotifyConnectionTestResult {
            return result ? .green : .red
        } else {
            return .gray
        }
    }
}

#Preview {
    MusicPlayerPreferencesView(
        model: MusicPlayerPreferencesModel(),
        playbackModel: PlaybackModel(preferences: MusicPlayerPreferencesModel())
    )
}
