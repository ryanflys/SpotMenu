import SwiftUI

struct PlaybackAppearancePreferencesView: View {
    @ObservedObject var model: PlaybackAppearancePreferencesModel
    @ObservedObject var musicPlayerPreferencesModel: MusicPlayerPreferencesModel
    @ObservedObject var playbackModel: PlaybackModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        ColorPicker(NSLocalizedString("appearance.hoverTintColor", comment: ""), selection: Binding(
                            get: { Color(model.hoverTintColor) },
                            set: { model.hoverTintColor = NSColor($0) }
                        ))

                        Picker(NSLocalizedString("appearance.foregroundColor", comment: ""), selection: $model.foregroundColor) {
                            ForEach(
                                PlaybackAppearancePreferencesModel.ForegroundColorOption
                                    .allCases
                            ) { option in
                                Text(option.rawValue.capitalized).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text(NSLocalizedString("appearance.colors", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("appearance.colors.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(NSLocalizedString("appearance.blurIntensity", comment: ""))
                                Spacer()
                                Text(String(format: "%.0f%%", model.blurIntensity * 100))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            Slider(value: $model.blurIntensity, in: 0...1)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(NSLocalizedString("appearance.hoverTintOpacity", comment: ""))
                                Spacer()
                                Text(String(format: "%.0f%%", model.hoverTintOpacity * 100))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            Slider(value: $model.hoverTintOpacity, in: 0...1)
                        }
                    } header: {
                        Text(NSLocalizedString("appearance.effects", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("appearance.effects.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)

                Form {
                    Section {
                        HStack {
                            Spacer()
                            PlaybackView(
                                model: playbackModel,
                                preferences: model,
                                musicPlayerPreferencesModel: musicPlayerPreferencesModel
                            )
                            Spacer()
                        }
                    } header: {
                        Text(NSLocalizedString("appearance.preview", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("appearance.preview.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
        .frame(maxWidth: 600)
        .padding(20)
    }
    }
}

#Preview {
    PlaybackAppearancePreferencesView(
        model: PlaybackAppearancePreferencesModel(),
        musicPlayerPreferencesModel: MusicPlayerPreferencesModel(),
        playbackModel: PlaybackModel(preferences: MusicPlayerPreferencesModel())
    )
}
