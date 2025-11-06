# NudgeBud — Product Requirements Document (PRD)
**Version:** 1.0  
**Owner:** Jerry  
**Platform:** iOS (iPhone) — watchOS later  
**File:** PRD_NudgeBud_v1.md  
**Last Updated:** 2025-11-05

---

## 1) Product story (why this exists)
Most habit apps nag and track. NudgeBud gives a tiny, emotionally-aware push that matches today’s mood and energy. One tap, one nudge, one small win. It learns which *voice* (persona) lands best for each user and moment.

## 2) Goals & non‑goals
**Goals**
- Deliver fast, low‑friction nudges aligned to the user’s *energy* and *available time*.
- Let users pick the *voice* that motivates them (e.g., Loving Partner, Tough‑Love Buddy, Grandma).
- Support *scheduled reminders* for specific tasks (e.g., “Aim practice 7pm M–F”), plus “start now” sessions.
- Learn user preference for personas from notification choices.
- Delightful UI with high readability in both light/dark; “liquid glass” is decorative only (never on controls).

**Non‑goals (v1)**
- Social feed, friends, or leaderboards.
- Complex habit analytics beyond streaks and simple counts.
- Cross‑platform (Android) — later.

## 3) Target users
- People who want gentle nudges vs. strict trackers.  
- ADHD / busy professionals who benefit from a tailored tone.  
- Gamers/creatives for skill micro‑practice (e.g., mouse‑aiming).

## 4) Value props
- **Emotionally smart**: pick a persona that works for you.
- **Low friction**: adjustable *in the notification* (Pattern B) — energy, time, and persona actions.
- **Fast setup**: templates, quick scheduling (DOW + 1–4× per day with smart default times).

---

## 5) Core feature set (MVP)
1. **Task‑aware Home**
   - Shows **Selected Task** with schedule summary (e.g., “M–F • 7:00 PM” + “Next: Tue 7:00 PM”).
   - Single primary CTA: **Pick a task** (no task) or **Start {task}** (task selected).
   - Optional overrides: Energy (Low/Med/High) and Time (2/5/10/20).

2. **Task Picker (sheet)**
   - Sections: *My Nudges* and *Templates* (Meditation, Guitar, Reading, Walk, Clear Inbox, Tidy Desk, **Practice mouse aiming skills**, etc.).
   - Selecting sets `currentTask` and loads any saved schedule.

3. **Schedule Sheet (sheet)**
   - Centered DOW chips (S M T W T F S), 1×/2×/3×/4× per day.
   - Smart defaults:  
     - 1× → anchor (default 7:00 PM)  
     - 2× → 9:00 AM & 7:00 PM  
     - 3× → 9:00 AM, 1:00 PM, 7:00 PM  
     - 4× → 9:00 AM, 1:00 PM, 5:00 PM, 9:00 PM

4. **Persona Picker (sheet)**
   - 3 quick personas (e.g., Loving Partner, Tough‑Love Buddy, Grandma) with one‑liners. Choose before a session.

5. **Session screen**
   - Timer for 2/5/10/20 (or template duration), Start/Pause/Done, swap persona.  
   - On Done → inline toast “Tiny win banked.” (never blocks taps).

6. **Interactive notifications (iOS Content Extension, Pattern B)**
   - Energy segmented (Low/Med/High), Time segmented (2/5/10/20), and **three persona actions** inside the notification.
   - Choose persona → logs preference and starts **ActivityKit Live Activity** timer without opening the app.
   - “Different task” action suggests a different task if relevant.

7. **Nudge Builder**
   - Create/edit nudges: title, category (Move/Focus/Reset/Learn), duration, schedule (DOW + 1–4× times), choose 3 personas, optional **external app deep link** (e.g., yousician:// for Guitar).

8. **Personality Lab**
   - **Accordions**: Active (up to 3), Available (Free), Premium (locked). Disabled personas remain visible and testable via **Try now**.  
   - States: on/off/muted; intensity slider (active only). Swap sheet if enabling >3.

9. **Streaks**
   - Daily streak count and recent wins (lightweight).

10. **Paywall (NudgeBud+)**
   - Premium unlocks: **AI Personality Builder**, all 15+ personas, fine‑tune sliders, insights/analytics, seasonal persona packs, **no ads**.  
   - Free tier shows ads **only after 12 delivered notifications** and **post‑win** (never pre‑task).

---

## 6) Monetization & pricing (initial hypothesis)
- **Free**: core features, limited personas, post‑win ads capped (1/day, 3/week) starting after 12 notifications delivered.  
- **Premium (NudgeBud+)**: $3.99/mo or $29.99/yr (intro). Includes AI Builder, persona packs, advanced insights, no ads.  
- Cost control: **API call limits/day** and local generation where possible; batch requests; cache persona lines.

---

## 7) UX principles
- Readable at a glance; high contrast in both themes.  
- Liquid glass/background blur **only** for decorative panels (not buttons/chips/toggles).  
- Notifications should never block navigation; in‑app **inline toasts** (non‑blocking).  
- Disabled personas remain visible to try/enable later.

---

## 8) System design / iOS
**iOS 17+**, SwiftUI, ActivityKit, UserNotifications.

- **Notification Content Extension**: energy/time segments + 3 persona actions.  
- **Live Activity**: countdown and quick complete/snooze.  
- **Storage (MVP)**: SwiftData in app + **App Group JSON cache** for the extension (QuickConfig). Consider Core Data App Group if full shared DB is required.  
- **External deep links**: `canOpenURL` check; App Store fallback; otherwise run in‑app.  
- **Analytics**: local counters for sessions completed, persona picks, energy/time overrides; optionally send aggregate events later (privacy‑first).

---

## 9) Data model (initial)
```
Task {
  id: UUID, title: String, emoji: String?, category: String,
  durationMin: Int, schedule: Schedule?,
  personas: [String], externalURL: URL?
}
Schedule {
  days: [Int],            // 1..7 (Sun=1)
  times: [DateComponents],// hour/minute only
  timesPerDay: Int, anchorTime: DateComponents?
}
Persona {
  id: String, name: String,
  state: "on"|"off"|"muted", intensity: Double  // 0..1
}
QuickConfig (App Group JSON for extension) {
  currentTaskTitle: String,
  personas: [String], energyDefault: "low"|"medium"|"high",
  quickDurations: [Int]
}
```

---

## 10) Key flows
1) **Start now from Home** → Persona Picker → Session → Win toast.  
2) **Schedule** → DOW + times per day → sensible defaults applied.  
3) **Notification action** → pick persona (and energy/time) → Live Activity countdown.  
4) **Builder** → create/edit task → optional deep link test.  
5) **Personality Lab** → enable/disable/try now; swap if >3 active.

---

## 11) Accessibility & quality bar
- Dynamic Type up to XXL; tappable areas ≥ 44×44.  
- VoiceOver labels for buttons/chips; clear hierarchy.  
- Contrast ≥ 4.5:1 for text over controls; no translucent controls for core actions.  
- Smooth 150–250ms animations; no blocking overlays.

---

## 12) Risks & mitigations
- **API cost**: cap persona generations/day; cache lines; batch calls; premium pays for heavy AI.  
- **Notification complexity**: keep exactly 3 persona actions; test on device early.  
- **Shared data with extensions**: start with App Group JSON cache; migrate to Core Data if needed.

---

## 13) Roadmap (90 days)
- **Milestone 1 (Weeks 1–3):** DesignSystem, Home, Task Picker, Schedule.  
- **Milestone 2 (Weeks 4–6):** Persona Picker, Session, Personality Lab (core), Nudge Builder (list).  
- **Milestone 3 (Weeks 7–9):** Notification extension (Pattern B) + Live Activity; deep links; paywall; ad gating.  
- **Polish (Weeks 10–12):** A11y pass, bug bash, App Store prep, TestFlight.

---

## 14) Definition of Done (per feature)
- Matches Figma visually (Dev nodes).  
- Light/Dark, Dynamic Type XL, VoiceOver labels.  
- Inline toasts (non‑blocking); no full‑screen overlays that intercept taps.  
- Unit check for schedule defaults and persona selection logging.  
- Screenshots recorded in PR (light/dark/XL).
