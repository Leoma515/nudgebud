//
//  HomeView.swift
//  NudgeBud
//
//  Created by OpenAI's ChatGPT on 11/6/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPresentingTaskPicker = false
    @State private var selectedVibe: VibeOption = .calmFocus

    private let upcomingTasks: [TaskCard] = [
        .init(title: "Publish weekly check-in", subtitle: "Accountability pod • Due tonight", icon: "person.2.circle.fill"),
        .init(title: "Prep progress snapshot", subtitle: "Share your wins • Due tomorrow", icon: "chart.bar.fill"),
        .init(title: "Plan playful micro-break", subtitle: "Joy queue • Friday", icon: "sparkles"),
    ]

    var body: some View {
        ZStack {
            // Surface color provides the base layer that adapts to light and dark mode without additional logic elsewhere.
            DesignTokens.Colors.surface(for: colorScheme)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    headerSection
                    vibeHeroCard
                    upcomingTasksSection
                }
                // Constrain content width so the layout scales gracefully on larger devices while keeping margins generous.
                .frame(maxWidth: DesignTokens.Layout.maxContentWidth)
                .padding(.horizontal, 24)
                .padding(.vertical, 36)
                .frame(maxWidth: .infinity)
            }
        }
        // Sheet hosts the task picker so the primary surface never gets cluttered with configuration controls.
        .sheet(isPresented: $isPresentingTaskPicker) {
            TaskPickerSheet(selectedVibe: $selectedVibe)
                .presentationDetents([.fraction(0.45), .large])
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Good afternoon, Kai 👋")
                .font(.title3.weight(.semibold))
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

            Text("Pick a vibe to set the tone for today’s nudges.")
                .font(.callout)
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.72))
        }
    }

    private var vibeHeroCard: some View {
        ZStack(alignment: .leading) {
            // Rounded rectangle mirrors the figma sheet styling with a subtle shadow for separation.
            RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous)
                .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous)
                        .stroke(DesignTokens.Colors.outline(for: colorScheme))
                )
                .onboardingCardShadow(colorScheme: colorScheme)

            VStack(alignment: .leading, spacing: 20) {
                Text(selectedVibe.headline)
                    .font(.title2.bold())
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                Text(selectedVibe.detail)
                    .font(.callout)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.72))
                    .fixedSize(horizontal: false, vertical: true)

                vibeActions
            }
            .padding(24)
        }
    }

    private var vibeActions: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(VibeOption.allCases) { vibe in
                        Button {
                            // Tapping a chip applies the vibe instantly while still allowing access to the full picker sheet.
                            selectedVibe = vibe
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: vibe.icon)
                                Text(vibe.title)
                            }
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(vibe == selectedVibe ? DesignTokens.Colors.primary(for: colorScheme).opacity(0.14) : DesignTokens.Colors.chipSelectedBackground(for: colorScheme))
                            )
                            .foregroundStyle(vibe == selectedVibe ? DesignTokens.Colors.primary(for: colorScheme) : DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.8))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            Button {
                // Sheet reveals a richer set of vibes and task templates that match the chosen energy.
                isPresentingTaskPicker = true
            } label: {
                HStack {
                    Text("Open task picker")
                    Spacer()
                    Image(systemName: "chevron.up")
                        .font(.subheadline.weight(.semibold))
                }
                .font(.callout.weight(.semibold))
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(DesignTokens.Colors.primary(for: colorScheme).opacity(0.12))
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var upcomingTasksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Today’s nudges")
                    .font(.headline)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                Spacer()

                Button("View all") {}
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                    .buttonStyle(.plain)
            }

            VStack(spacing: 14) {
                ForEach(upcomingTasks) { task in
                    TaskCardView(task: task, colorScheme: colorScheme)
                }
            }
        }
    }
}

private struct TaskCardView: View {
    let task: TaskCard
    let colorScheme: ColorScheme

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon bubble anchors the card visually and provides a quick semantic cue.
            Image(systemName: task.icon)
                .font(.title2)
                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(DesignTokens.Colors.chipSelectedBackground(for: colorScheme))
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                Text(task.subtitle)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.68))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.4))
                .padding(.top, 4)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(DesignTokens.Colors.outline(for: colorScheme))
                )
        )
    }
}

private struct TaskCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}

private enum VibeOption: String, CaseIterable, Identifiable {
    case calmFocus
    case joyfulMomentum
    case gentleReset
    case boldSprint

    var id: String { rawValue }

    var title: String {
        switch self {
        case .calmFocus: "Calm focus"
        case .joyfulMomentum: "Joyful momentum"
        case .gentleReset: "Gentle reset"
        case .boldSprint: "Bold sprint"
        }
    }

    var icon: String {
        switch self {
        case .calmFocus: "leaf"
        case .joyfulMomentum: "sun.max.fill"
        case .gentleReset: "moon.zzz"
        case .boldSprint: "bolt.fill"
        }
    }

    var headline: String {
        switch self {
        case .calmFocus:
            return "Settle into calm focus"
        case .joyfulMomentum:
            return "Ride joyful momentum"
        case .gentleReset:
            return "Give yourself a gentle reset"
        case .boldSprint:
            return "Go all-in on a bold sprint"
        }
    }

    var detail: String {
        switch self {
        case .calmFocus:
            return "Soft instrumental playlists, gentle reminder cadence, and breathing breaks keep you centered while nudging projects forward."
        case .joyfulMomentum:
            return "Pair high-energy check-ins with celebratory cues so your accountability pod feels the wins as much as the progress."
        case .gentleReset:
            return "Pause, tidy up loose threads, and spotlight care tasks that help future-you feel supported."
        case .boldSprint:
            return "Dial up the urgency, loop in collaborators, and schedule bite-sized milestones to keep momentum blazing."
        }
    }
}

struct TaskPickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedVibe: VibeOption

    private let vibeTemplates: [VibeTemplate] = [
        .init(vibe: .calmFocus, tasks: ["Deep work block", "Mindful pause", "Reflect + share"]),
        .init(vibe: .joyfulMomentum, tasks: ["Celebrate last win", "Send hype DM", "Queue playful break"]),
        .init(vibe: .gentleReset, tasks: ["Reset workspace", "Check-in with body", "Plan tiny treat"]),
        .init(vibe: .boldSprint, tasks: ["Prioritize blockers", "Sync with pod", "Log micro-progress"]),
    ]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Pick a vibe").font(.footnote).foregroundStyle(.secondary)) {
                    ForEach(vibeTemplates) { template in
                        Button {
                            // Selecting a vibe updates state and closes the sheet in a single tap.
                            selectedVibe = template.vibe
                            dismiss()
                        } label: {
                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(DesignTokens.Colors.primary(for: colorScheme).opacity(0.16))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: template.vibe.icon)
                                            .font(.headline)
                                            .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                                    )

                                VStack(alignment: .leading, spacing: 6) {
                                    Text(template.vibe.title)
                                        .font(.body.weight(.semibold))
                                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                                    Text(template.vibe.detail)
                                        .font(.footnote)
                                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.68))
                                        .lineLimit(2)

                                    // Display suggested tasks to communicate what changes alongside the vibe.
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 8)], spacing: 8) {
                                        ForEach(template.tasks, id: \.self) { task in
                                            Text(task)
                                                .font(.caption.weight(.semibold))
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(
                                                    Capsule()
                                                        .fill(DesignTokens.Colors.chipSelectedBackground(for: colorScheme))
                                                )
                                                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                                        }
                                    }
                                    .padding(.top, 6)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .listRowBackground(DesignTokens.Colors.surface(for: colorScheme))
                    }
                }
            }
            // List background inherits the surface color so it matches the base layer seen behind the translucent sheet.
            .scrollContentBackground(.hidden)
            .background(DesignTokens.Colors.surface(for: colorScheme))
            .navigationTitle("Task picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

private struct VibeTemplate: Identifiable {
    let id = UUID()
    let vibe: VibeOption
    let tasks: [String]
}

#Preview("Home – Light") {
    HomeView()
        .preferredColorScheme(.light)
}

#Preview("Home – Dark") {
    HomeView()
        .preferredColorScheme(.dark)
}

#Preview("Home – XL") {
    HomeView()
        .previewLayout(.fixed(width: 1024, height: 768))
        .preferredColorScheme(.light)
}
