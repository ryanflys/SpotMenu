import SwiftUI

struct AboutPreferencesView: View {
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // App Icon and Name
                VStack(spacing: 12) {
                    Image(nsImage: NSApp.applicationIconImage)
                        .resizable()
                        .frame(width: 128, height: 128)
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)

                    Text("SpotMenu")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(String(format: NSLocalizedString("about.version", comment: ""), appVersion, buildNumber))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 20)

                Divider()
                    .padding(.horizontal, 40)

                // Donation Section
                VStack(spacing: 12) {
                    Text(NSLocalizedString("about.supportDevelopment", comment: ""))
                        .font(.headline)

                    Text(NSLocalizedString("about.supportMessage", comment: ""))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)

                    Button(action: {
                        if let url = URL(string: "https://paypal.me/kmikiy") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.white)
                            Text(NSLocalizedString("about.donatePayPal", comment: ""))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                }
                .padding(.vertical, 8)

                Divider()
                    .padding(.horizontal, 40)

                // Description
                VStack(spacing: 8) {
                    Text(NSLocalizedString("about.description", comment: ""))
                        .font(.headline)

                    Text(NSLocalizedString("about.builtWith", comment: ""))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Divider()
                    .padding(.horizontal, 40)

                // Links
                VStack(spacing: 12) {
                    Button(action: {
                        if let url = URL(string: "https://github.com/kmikiy/SpotMenu") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "link")
                            Text(NSLocalizedString("about.viewOnGitHub", comment: ""))
                        }
                    }
                    .buttonStyle(.link)

                    Button(action: {
                        if let url = URL(string: "https://kmikiy.github.io/SpotMenu") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "globe")
                            Text(NSLocalizedString("about.website", comment: ""))
                        }
                    }
                    .buttonStyle(.link)
                }

                Spacer()

                // Copyright
                Text(NSLocalizedString("about.madeBy", comment: ""))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: 400)
            .padding(20)
        }
    }
}

#Preview {
    AboutPreferencesView()
}
