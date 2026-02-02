import KeyboardShortcuts
import SwiftUI

enum MediaAction: String, CaseIterable, Identifiable {
    case playPause = "Play / Pause"
    case nextTrack = "Next Track"
    case previousTrack = "Previous Track"

    var id: String { self.rawValue }
    var shortcutName: KeyboardShortcuts.Name {
        switch self {
        case .playPause: return .playPause
        case .nextTrack: return .nextTrack
        case .previousTrack: return .previousTrack
        }
    }
}

struct ShortcutPreferencesView: View {
    @ObservedObject var model: PlaybackModel
    @ObservedObject var musicPlayerPreferencesModel: MusicPlayerPreferencesModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        ForEach(MediaAction.allCases) { action in
                            HStack {
                                Text(action.rawValue)
                                Spacer()
                                KeyboardShortcuts.Recorder(for: action.shortcutName)
                            }
                        }
                    } header: {
                        Text(NSLocalizedString("shortcuts.playbackControls", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("shortcuts.playbackControls.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                if model.isLikingImplemented
                    && musicPlayerPreferencesModel.likingEnabled
                {
                    Form {
                        Section {
                            HStack {
                                Text(NSLocalizedString("shortcuts.likeTrack", comment: ""))
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .likeTrack)
                            }

                            HStack {
                                Text(NSLocalizedString("shortcuts.unlikeTrack", comment: ""))
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .unlikeTrack)
                            }

                            HStack {
                                Text(NSLocalizedString("shortcuts.toggleLike", comment: ""))
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .toggleLike)
                            }
                        } header: {
                            Text(NSLocalizedString("shortcuts.trackLiking", comment: ""))
                        } footer: {
                            Text(NSLocalizedString("shortcuts.trackLiking.footer", comment: ""))
                        }
                    }
                    .formStyle(.grouped)
                    .scrollContentBackground(.hidden)
                }
            }
        .frame(maxWidth: 600)
        .padding(20)
    }
    }
}

#Preview {
    ShortcutPreferencesView(
        model: PlaybackModel(preferences: MusicPlayerPreferencesModel()),
        musicPlayerPreferencesModel: MusicPlayerPreferencesModel()
    )
}
