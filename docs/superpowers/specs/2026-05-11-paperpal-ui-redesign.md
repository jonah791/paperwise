# PaperPal UI Redesign — Design Spec

## Overview

Full visual redesign of PaperPal's Flutter UI, transforming it from default Material 3 styling into an Alice-in-Wonderland-inspired dark/light dual theme with premium visual effects.

## Design Direction

- **Theme:** Alice in Wonderland whimsical
- **Dark palette:** `#07050D` bg, `#120C1F` surface, `#E8B84B` gold accent, `#9B6DF7` purple accent
- **Light palette:** `#FFFBF3` bg, `#FFF6E5` surface, `#C28A2C` gold accent, `#6D28D9` purple accent
- **Typography:** Playfair Display (headings), Inter (UI), Noto Serif SC (Chinese reading)
- **Key visual elements:** Playing card suits (♠♥♦♣) as decorative motifs, gold gradients, subtle texture overlay

## Implementation Phases

### Phase 1: Theme System (`lib/ui/theme/app_theme.dart`)

- Replace seed-based color scheme with explicit dark/light `ColorScheme` definitions
- Custom `TextTheme` — Playfair Display for titles, Inter for body, Noto Serif SC for Chinese
- Custom `CardTheme` — 12px border radius, gradient background, subtle gold left border accent
- Custom `InputDecorationTheme` — dark surface input, gold focus border
- Custom `ElevatedButtonTheme` — gold gradient buttons
- Custom `AppBarTheme` — no elevation, minimal, gold accent
- CSS variables → Dart `ThemeData` extensions
- Animated theme switching (0.4s ease transitions)

### Phase 2: Background & Atmosphere (`lib/ui/widgets/`)

- Animated gradient background widget (3-point radial gradient, slow RGB drift via `AnimationController`)
- Subtle SVG pattern overlay (card suit pattern at 2-3% opacity)
- Progress bar at top (3px gold gradient, scroll-driven)
- Page transition overlay (slide curtain effect)

### Phase 3: Loading & Animation System

- Card spread loading animation (♠♥♦♣ sequential fade/rise)
- FadeSlideUp transition for list items (papers, search results)
- Staggered entrance for card lists
- Typing indicator for AI chat (3-dot bounce)
- Skeleton loading screen for paper list
- Floating card decorations on hero/welcome page

### Phase 4: Page-by-Page Polish

#### Welcome Page
- Dark gradient background with floating suit decorations
- Hero title with gold gradient text
- "掉进兔子洞" tagline (italic Playfair Display)
- Gradient CTA button

#### Search Page
- Redesigned input (dark surface, gold focus)
- Staggered result card entrance animation
- Filter chips with active gold styling

#### Library Page
- Gradient paper cards with gold left accent bar
- Per-card playing suit marker
- Staggered list animation
- Redesigned filter chips

#### Read Page
- Reading area with subtle gradient surface
- Gold equation block styling
- Note cards with gold left border accent
- `.mark` style highlight (gold underline highlight, 50% opacity)
- Text with gold accent highlighting for key terms

#### Chat / AI Soul
- User bubble: purple gradient fill
- AI bubble: elevated surface gradient, gold accent text
- Soul selector chips: gold gradient active state
- AI avatar: gold gradient circle with letter initial

#### Settings Page
- Redesigned card sections with gradient surfaces
- Gold-accented form inputs
- Soul selector with gold active state

### Phase 5: Scroll Progress

- Top-of-page progress bar (3px, gold gradient, 0 → 100% scroll)
- CSS `var(--progress)` pattern in Flutter via `ScrollController`

### Phase 6: Page Transitions

- Custom `PageTransitionsBuilder` — curtain slide overlay on navigation
- 600ms cubic-bezier transition

## Files to Modify

| File | Changes |
|------|---------|
| `lib/ui/theme/app_theme.dart` | Complete rewrite — explicit ColorScheme, custom TextTheme, CardTheme, InputDecorationTheme, ButtonTheme |
| `lib/main.dart` | Add transition theme, wrap with animated theme builder |
| `lib/ui/pages/welcome_page.dart` | Hero gradient, floating decorations, gold text |
| `lib/ui/pages/search_page.dart` | Card styling, animation, input theme |
| `lib/ui/pages/library_page.dart` | Gradient cards, suit markers, staggered animation |
| `lib/ui/pages/read_page.dart` | Highlight styling, note cards, equation block |
| `lib/ui/pages/settings_page.dart` | Section card styling, soul chip active state |
| `lib/ui/widgets/soul_selector.dart` | Gold gradient active chip, updated styling |
| `lib/ui/widgets/avatar_picker.dart` | Themed styling alignment |
| `lib/ui/widgets/explain_dialog.dart` | Themed dialog styling |
| `lib/core/services/parse_service.dart` | No changes (pure Dart logic) |

## New Files to Create

| File | Purpose |
|------|---------|
| `lib/ui/widgets/animated_background.dart` | Animated gradient background widget |
| `lib/ui/widgets/progress_bar.dart` | Top scroll progress bar |
| `lib/ui/widgets/skeleton_loader.dart` | Skeleton loading placeholder |
| `lib/ui/widgets/staggered_list.dart` | Staggered entrance animation wrapper |
| `lib/ui/widgets/card_spinner.dart` | Card suit loading indicator |
| `lib/ui/widgets/page_transition.dart` | Custom page transition builders |

## Out of Scope

- Citation network graph (user declined)
- Functional changes to services/models/CLI
- PDF annotation/highlight persistence
- Font file embedding (uses Google Fonts dependency)
