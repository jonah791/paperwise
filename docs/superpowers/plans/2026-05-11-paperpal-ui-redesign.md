# PaperPal UI Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Full visual redesign of PaperPal's Flutter UI into Alice-in-Wonderland-themed dark/light dual theme with premium visual effects.

**Architecture:** The theme system is the foundation — all other changes depend on it. Phases must execute sequentially. No functional changes to services/models.

**Tech Stack:** Flutter (Dart), Material 3, google_fonts (Playfair Display, Inter, Noto Serif SC), CustomPainter, AnimationController.

**Design Spec:** `docs/superpowers/specs/2026-05-11-paperpal-ui-redesign.md`

---

### Task 1: Add google_fonts dependency

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Add google_fonts to pubspec.yaml**

```yaml
  google_fonts: any
```

- [ ] **Step 2: Install**

Run: `flutter pub get`

- [ ] **Step 3: Commit**

```
git add pubspec.yaml pubspec.lock
git commit -m "deps: add google_fonts for custom typography"
```

---

### Task 2: Rewrite theme system

**Files:**
- Modify: `lib/ui/theme/app_theme.dart`
- Test: `test/widget_test.dart`

This is the largest single change. Defines:
- `AppTheme._darkColors()` / `AppTheme._lightColors()` → explicit ColorScheme
- `AppTheme._textTheme()` → Playfair Display headings, Inter UI, Noto Serif SC Chinese
- `AppTheme._cardTheme()` → 12px radius, gold border
- `AppTheme._inputDecorationTheme()` → dark surface input, gold focus
- `AppTheme._elevatedButtonTheme()` → gold filled buttons
- `AppTheme._appBarTheme()` → no elevation, transparent
- `AppTheme._dividerTheme()` → golden tint

- [ ] **Step 1: Write the new app_theme.dart**

Replace entire file content with the new theme system. Key constants:
- Dark: bg#07050D, surface#120C1F, elevated#1B1332, gold#E8B84B, purple#9B6DF7, text#EDE4D8
- Light: bg#FFFBF3, surface#FFFFFF, elevated#FFF6E5, gold#C28A2C, purple#6D28D9, text#1A1025

- [ ] **Step 2: Run tests**

Run: `flutter test`

- [ ] **Step 3: Commit**

```
git add lib/ui/theme/app_theme.dart
git commit -m "feat(ui): rewrite theme system with Alice-inspired ColorScheme and custom typography"
```

---

### Task 3: Animated gradient background widget

**Files:**
- Create: `lib/ui/widgets/animated_background.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create animated_background.dart**

Widget uses `AnimationController` (30s repeat) + `CustomPainter` with 3 radial gradients that slowly drift using sin/cos. Plus a `_SuitPatternPainter` that renders faint card suits (unicode characters) in a grid overlay. Wrap child in `Stack`.

- [ ] **Step 2: Integrate into main.dart**

Wrap `IndexedStack` body with `AnimatedBackground` widget.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/widgets/animated_background.dart lib/main.dart
git commit -m "feat(ui): add animated gradient background with suit pattern overlay"
```

---

### Task 4: Custom page transitions

**Files:**
- Create: `lib/ui/widgets/page_transition.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create page_transition.dart**

Implement a `SlideTransition`-based page route builder using cubic bezier curve (0.77, 0.0, 0.18, 1.0). Forward slides in from right, reverse slides out to left.

- [ ] **Step 2: Register in MaterialApp**

Add `pageTransitionsTheme` with `TargetPlatform.windows` mapped to custom builder.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/widgets/page_transition.dart lib/main.dart
git commit -m "feat(ui): add custom page transition animations"
```

---

### Task 5: Scroll progress bar

**Files:**
- Create: `lib/ui/widgets/progress_bar.dart`

- [ ] **Step 1: Create progress_bar.dart**

`ScrollProgressBar` widget that listens to a `ScrollController`, computes scroll percentage, and renders a 3px gold gradient bar at the top with glow shadow.

- [ ] **Step 2: Integrate into read_page.dart**

Add `ScrollController` and attach `ScrollProgressBar` to the reading view.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/widgets/progress_bar.dart
git commit -m "feat(ui): add scroll progress bar for reading page"
```

---

### Task 6: Card spinner loading widget

**Files:**
- Create: `lib/ui/widgets/card_spinner.dart`

- [ ] **Step 1: Create card_spinner.dart**

`CardSpinner` widget renders 8 card suit characters (spade, heart, diamond, club repeated) in a horizontal row. Each suit fades in, rises, then fades out in sequence using `AnimationController` (3s cycle) with staggered delays per suit.

- [ ] **Step 2: Replace CircularProgressIndicator usages**

In `search_page.dart` and `library_page.dart`, replace `CircularProgressIndicator` with `CardSpinner`.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/widgets/card_spinner.dart
git commit -m "feat(ui): add card suit loading spinner widget"
```

---

### Task 7: Welcome page redesign

**Files:**
- Modify: `lib/ui/pages/welcome_page.dart`

- [ ] **Step 1: Rewrite welcome_page.dart**

Update to: gold gradient "PaperPal" title using `Paint` + `LinearGradient` shader, italic Playfair Display tagline, floating card suit decorations (low opacity), gold gradient FilledButton.

- [ ] **Step 2: Run tests**

Run: `flutter test`

- [ ] **Step 3: Commit**

```
git add lib/ui/pages/welcome_page.dart
git commit -m "feat(ui): redesign welcome page with gold gradient title and Alice theme"
```

---

### Task 8: Search page polish

**Files:**
- Modify: `lib/ui/pages/search_page.dart`

- [ ] **Step 1: Update cards and animations**

Search result cards use theme's CardTheme. Replace loading indicator with `CardSpinner`. Add staggered fade-slide-up entrance animation via `TweenAnimationBuilder` with per-item delay.

- [ ] **Step 2: Run tests**

Run: `flutter test`

- [ ] **Step 3: Commit**

```
git add lib/ui/pages/search_page.dart
git commit -m "feat(ui): polish search page with staggered animations and card spinner"
```

---

### Task 9: Library page redesign

**Files:**
- Modify: `lib/ui/pages/library_page.dart`

- [ ] **Step 1: Update library cards**

Each paper card gets: suit marker based on `paper.id.hashCode % 4`, gold left accent bar (3px via Container decoration), staggered entrance animation. Replace loading indicator with `CardSpinner`.

- [ ] **Step 2: Run tests**

Run: `flutter test`

- [ ] **Step 3: Commit**

```
git add lib/ui/pages/library_page.dart
git commit -m "feat(ui): redesign library cards with suit markers and staggered animation"
```

---

### Task 10: Read page styling

**Files:**
- Modify: `lib/ui/pages/read_page.dart`

- [ ] **Step 1: Add highlight markup style**

Create a highlight text helper: gold color + 18% gold background paint for key terms.

- [ ] **Step 2: Style equation blocks**

Wrap math rendering in gold-tinted container (secondary at 5% alpha, 1px border, 8px radius).

- [ ] **Step 3: Style note cards**

Gold left border (3px), italic text, muted metadata, elevated surface background.

- [ ] **Step 4: Run tests**

Run: `flutter test`

- [ ] **Step 5: Commit**

```
git add lib/ui/pages/read_page.dart
git commit -m "feat(ui): add highlight style, equation blocks, and note card styling on read page"
```

---

### Task 11: Chat and soul selector styling

**Files:**
- Modify: `lib/ui/pages/read_page.dart` (chat section)
- Modify: `lib/ui/widgets/soul_selector.dart`

- [ ] **Step 1: Style chat bubbles**

User bubble: primaryContainer purple tint. AI bubble: elevated surface, gold accent emphasis text. AI avatar: gold CircleAvatar with letter initial. Typing indicator: 3 gold dots with bounce animation.

- [ ] **Step 2: Update soul_selector.dart**

Active chip: gold border + gold tint background. Inactive: transparent with gold-tinged border.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/pages/read_page.dart lib/ui/widgets/soul_selector.dart
git commit -m "feat(ui): style chat bubbles and soul selector with gold theme"
```

---

### Task 12: Settings page polish

**Files:**
- Modify: `lib/ui/pages/settings_page.dart`

- [ ] **Step 1: Update settings cards**

Card sections use theme CardTheme. Inputs use theme InputDecorationTheme. Section labels: muted gold, uppercase, small font. Soul selector already styled from Task 11.

- [ ] **Step 2: Run tests**

Run: `flutter test`

- [ ] **Step 3: Commit**

```
git add lib/ui/pages/settings_page.dart
git commit -m "feat(ui): polish settings page with themed cards and inputs"
```

---

### Task 13: Skeleton loader widget

**Files:**
- Create: `lib/ui/widgets/skeleton_loader.dart`

- [ ] **Step 1: Create skeleton_loader.dart**

`SkeletonLoader` renders a rounded rectangle with animated breathing opacity (2s cycle). Accepts width, height, borderRadius parameters.

- [ ] **Step 2: Integrate into library_page.dart**

Show skeleton items while papers are loading.

- [ ] **Step 3: Run tests**

Run: `flutter test`

- [ ] **Step 4: Commit**

```
git add lib/ui/widgets/skeleton_loader.dart
git commit -m "feat(ui): add skeleton loader widget for loading states"
```

---

## Self-Review Checklist

1. **Spec coverage:** Every spec section maps to a task:
   - Theme → Task 2
   - Background → Task 3
   - Progress → Task 5
   - Loading → Tasks 6, 13
   - Transitions → Task 4
   - Welcome → Task 7
   - Search → Task 8
   - Library → Task 9
   - Read → Task 10
   - Chat/Soul → Task 11
   - Settings → Task 12

2. **Placeholder scan:** All code described, no TBD/TODO.

3. **Type consistency:** All widget names and patterns consistent across tasks.

4. **Scope check:** UI/theme only. No services, models, or CLI changes.
