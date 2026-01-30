import SwiftUI

enum PreferencesSection: String, CaseIterable, Identifiable {
    case player = "Player"
    case appearance = "Appearance"
    case menuBar = "Menu Bar"
    case shortcuts = "Shortcuts"
    case language = "Language"
    case about = "About"

    var id: String { rawValue }

    var localizedName: String {
        switch self {
        case .player:
            return NSLocalizedString("preferences.player", comment: "")
        case .appearance:
            return NSLocalizedString("preferences.appearance", comment: "")
        case .menuBar:
            return NSLocalizedString("preferences.menuBar", comment: "")
        case .shortcuts:
            return NSLocalizedString("preferences.shortcuts", comment: "")
        case .language:
            return NSLocalizedString("preferences.language", comment: "")
        case .about:
            return NSLocalizedString("preferences.about", comment: "")
        }
    }

    var icon: String {
        switch self {
        case .player:
            return "music.note"
        case .appearance:
            return "paintbrush"
        case .menuBar:
            return "menubar.rectangle"
        case .shortcuts:
            return "command"
        case .language:
            return "globe"
        case .about:
            return "info.circle"
        }
    }
}

struct PreferencesView: View {
    @ObservedObject var menuBarPreferencesModel: MenuBarPreferencesModel
    @ObservedObject var playbackModel: PlaybackModel
    @ObservedObject var musicPlayerPreferencesModel: MusicPlayerPreferencesModel
    @ObservedObject var playbackAppearancePreferencesModel:
        PlaybackAppearancePreferencesModel
    @ObservedObject var languagePreferencesModel: LanguagePreferencesModel

    @State private var selectedSection: PreferencesSection? = .player

    var body: some View {
        NavigationSplitView {
            List(PreferencesSection.allCases, selection: $selectedSection) {
                section in
                Label(section.localizedName, systemImage: section.icon)
                    .tag(section)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 250)
            .listStyle(.sidebar)
            .safeAreaInset(edge: .top, spacing: 0) {
                // Extra space for traffic lights
                Color.clear.frame(height: 8)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                // Quit button at bottom of sidebar
                VStack(spacing: 0) {
                    Divider()
                    Button(action: {
                        NSApp.terminate(nil)
                    }) {
                        Label(NSLocalizedString("common.quit", comment: ""), systemImage: "power")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                    .keyboardShortcut("q", modifiers: [.command])
                }
                .background(Color(nsColor: .windowBackgroundColor))
            }
        } detail: {
            if let selectedSection = selectedSection {
                detailView(for: selectedSection)
                    .navigationTitle(selectedSection.localizedName)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(nsColor: .windowBackgroundColor))
                    .overlay(alignment: .top) {
                        LinearGradient(
                            colors: [
                                Color(nsColor: .windowBackgroundColor).opacity(
                                    1
                                ),
                                Color(nsColor: .windowBackgroundColor).opacity(
                                    0.90
                                ),
                                Color(nsColor: .windowBackgroundColor).opacity(
                                    0.0
                                ),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 60)
                        .allowsHitTesting(false)
                        .ignoresSafeArea(edges: .top)
                    }
            } else {
                Text(NSLocalizedString("common.selectSection", comment: ""))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(nsColor: .windowBackgroundColor))
            }
        }
        .navigationSplitViewStyle(.balanced)
    }

    @ViewBuilder
    private func detailView(for section: PreferencesSection) -> some View {
        switch section {
        case .player:
            MusicPlayerPreferencesView(
                model: musicPlayerPreferencesModel,
                playbackModel: playbackModel
            )
        case .appearance:
            PlaybackAppearancePreferencesView(
                model: playbackAppearancePreferencesModel,
                musicPlayerPreferencesModel: musicPlayerPreferencesModel,
                playbackModel: playbackModel
            )
        case .menuBar:
            MenuBarPreferencesView(
                model: menuBarPreferencesModel,
                playbackModel: playbackModel,
                musicPlayerPreferencesModel: musicPlayerPreferencesModel
            )
        case .shortcuts:
            ShortcutPreferencesView(model: playbackModel, musicPlayerPreferencesModel: musicPlayerPreferencesModel)
        case .language:
            LanguagePreferencesView(model: languagePreferencesModel)
        case .about:
            AboutPreferencesView()
        }
    }
}

#Preview {
    PreferencesView(
        menuBarPreferencesModel: MenuBarPreferencesModel(),
        playbackModel: PlaybackModel(
            preferences: MusicPlayerPreferencesModel()
        ),
        musicPlayerPreferencesModel: MusicPlayerPreferencesModel(),
        playbackAppearancePreferencesModel: PlaybackAppearancePreferencesModel(),
        languagePreferencesModel: LanguagePreferencesModel()
    )
}
