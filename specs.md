# COMM 205 Exam B Review Session — Full Build Spec

**Deliverable:** One self-contained `index.html` file (inline CSS + inline JS) deployable on Vercel.  
**Audience:** Undergraduate COMM 205 students at UBC Sauder — many non-technical — preparing for Exam B (worth 40% of final grade).  
**Tone:** Clear, supportive, high-signal, academic but approachable. Not corporate, not childish.  
**Session format:** Two parts — Part 1 is lecture-style review, Part 2 is hands-on mini-projects.  
**Total slides:** 28 (slides 0–27)

---

## TABLE OF CONTENTS

1. [Design System](#design-system)
2. [Technical Build Constraints](#technical-build-constraints)
3. [Navigation & UI](#navigation--ui)
4. [Layout Templates](#layout-templates)
5. [Interactive Component Specs](#interactive-component-specs)
6. [Slide-by-Slide Definitions](#slide-by-slide-definitions)
7. [Content Writing Rules](#content-writing-rules)

---

## DESIGN SYSTEM

### Color Palette

```css
:root {
  --orange-brand:    #f09b1a;   /* CMP branded orange — primary accent */
  --ice-bg:          #D9ECF7;   /* light blue tint for backgrounds */
  --card-white:      #F6F9FC;   /* off-white card surfaces */
  --amber-warn:      #F4B942;   /* exam tips, important callouts */
  --coral-mistake:   #D96C6C;   /* common mistakes, danger */
  --green-correct:   #4F9D69;   /* correct answers, takeaways */
  --dark-text:       #1a1a2e;   /* primary text */
  --mid-text:        #4a4a6a;   /* secondary text */
  --light-text:      #7a7a9a;   /* tertiary / muted text */
  --code-bg:         #1e1e2e;   /* dark background for code blocks */
  --code-text:       #e0e0e0;   /* light text inside code blocks */
  --excel-green:     #217346;   /* Excel brand color for Excel section accent */
  --r-blue:          #276DC3;   /* R brand color for R section accent */
  --slide-bg:        #f0f4f8;   /* default slide background */
}
```

### Typography

```css
/* Headlines — bold, modern, slightly editorial */
font-family: "Space Grotesk", "Inter", "Segoe UI", system-ui, sans-serif;

/* Body — readable, generous line height */
font-family: "Inter", "Segoe UI", system-ui, sans-serif;
line-height: 1.6;

/* Code / Formulas — must be large enough to read from back of classroom */
font-family: "JetBrains Mono", "SF Mono", "Consolas", "Liberation Mono", monospace;
font-size: 1.1rem; /* minimum for code on slides */
```

Load from Google Fonts:
```html
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

### Typography Scale

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| Slide title | 2.5rem | 700 | `--dark-text` |
| Section label (e.g. "EXCEL") | 0.85rem uppercase tracking-wide | 600 | `--excel-green` or `--r-blue` |
| Body text | 1.15rem | 400 | `--mid-text` |
| Code / formula | 1.1rem–1.3rem | 400 | `--code-text` on `--code-bg` |
| Exam tip text | 1rem | 500 | `--amber-warn` |
| Mistake text | 1rem | 500 | `--coral-mistake` |
| Takeaway text | 1rem | 500 | `--green-correct` |

### Spacing & Layout

- Slide container: `max-width: 1100px`, centered, `padding: 3rem 4rem`
- Card padding: `1.5rem 2rem`
- Card border-radius: `12px`
- Card shadows: `0 2px 12px rgba(0,0,0,0.06)`
- Section divider slides: full bleed color background
- Interactive components: `border: 2px solid var(--orange-brand)`, `border-radius: 8px`

### Motion

- Slide transitions: `opacity` fade, 300ms ease
- Content entrance: staggered fade-up, 50ms delay per item, 400ms duration
- Interactive components: instant response (no transition delay on user input)
- Hover effects on buttons/cards: `transform: translateY(-2px)`, `box-shadow` lift
- **No gimmicky animations.** Motion serves comprehension and pacing only.

### Iconography

Use simple inline SVG icons or Unicode symbols. No icon library needed.
- Exam tip: `💡` or a lightbulb SVG
- Common mistake: `⚠️` or a warning triangle SVG
- Correct/takeaway: `✓` checkmark SVG
- Interactive hint: `🖱️` or pointer SVG

---

## TECHNICAL BUILD CONSTRAINTS

### File Structure
```
index.html          ← single file, everything inline
vercel.json         ← optional, just: { "routes": [{ "src": "/(.*)", "dest": "/index.html" }] }
```

### Implementation Rules
1. **Single HTML file** — all CSS in `<style>`, all JS in `<script>`
2. **No frameworks** — vanilla HTML/CSS/JS only
3. **No CDN dependencies required** — Google Fonts is the only external request (degrade gracefully with system fonts if offline)
4. **No build step** — open `index.html` in a browser and it works
5. **Desktop-first** — optimize for 1280×720 and 1920×1080 projector resolutions
6. **Must also display cleanly** on 13" laptop screens (1280×800) and tablets
7. **Accessibility** — all interactive components keyboard-accessible, sufficient color contrast (WCAG AA minimum)

### Performance
- Target: first meaningful paint < 500ms
- No lazy-loading needed (single file, everything is inline)
- Keep total file size under 500KB

---

## NAVIGATION & UI

### Required Navigation Elements

1. **Progress bar** — thin bar at top of viewport, fills left-to-right as slides advance. Color: `--orange-brand`.
2. **Slide counter** — bottom-right corner, format: `4 / 28`, muted text.
3. **Arrow buttons** — bottom-center, left/right arrows for prev/next. Styled as subtle circular buttons.
4. **Keyboard navigation:**
   - `→` or `Space` or `Enter` = next slide
   - `←` or `Backspace` = previous slide
   - `Escape` = toggle overview/agenda overlay
5. **Touch/click** — clicking right half of slide = next, left half = prev (for trackpad/touch users)

### Optional (implement if time allows)
- **Agenda overlay** — press `Escape` to see a grid of all slide titles, click to jump. Group slides by section (Intro, Excel, R, Activity).
- **Section indicator** — small label showing current section (e.g., "EXCEL · Slide 5 of 14") beneath the slide title.

### Slide Container

```
┌─────────────────────────────────────────────┐
│ [===progress bar====                      ] │  ← top, 3px height
│                                             │
│   EXCEL                                     │  ← section label
│   Slide Title                               │  ← h1
│                                             │
│   ┌─────────────┐  ┌─────────────┐          │
│   │  Card 1     │  │  Card 2     │          │  ← content area
│   └─────────────┘  └─────────────┘          │
│                                             │
│   ┌─ Interactive Component ──────────────┐  │
│   │                                      │  │
│   └──────────────────────────────────────┘  │
│                                             │
│   💡 Exam Tip: ...                          │  ← bottom callout
│   ⚠️ Common Mistake: ...                    │
│                                             │
│              ◀  ▶           4 / 28          │  ← nav + counter
└─────────────────────────────────────────────┘
```

---

## LAYOUT TEMPLATES

Every slide uses one of these layout types. The coding agent should implement each as a reusable CSS class.

### `layout-hero`
Full-slide title treatment. Large centered title, subtitle below, optional background motif.
Used for: title slide, section dividers.

### `layout-intro`
Left-aligned title + body text. Optional image or callout card on right. 
Used for: about-me, overview, housekeeping.

### `layout-concept`
Title at top. One or two content cards below (side by side on desktop, stacked on mobile). Each card can contain: heading, body text, code block, or interactive component. Below cards: exam tip and/or common mistake callout.
Used for: most teaching slides.

### `layout-compare`
Title at top. Two columns, each with a heading, content, and optional code block. A visual divider (thin line or "vs" badge) between columns. Below: key difference callout.
Used for: AND vs OR, INDEX vs MATCH, FIND vs SEARCH, SUBSTITUTE vs REPLACE.

### `layout-interactive`
Title at top. Full-width interactive component takes up 60–70% of slide height. Small instruction text above the component. Below: brief explanation text.
Used for: slides with live Excel function simulators.

### `layout-workflow`
Title at top. Horizontal or vertical step pipeline (3–5 steps connected by arrows). Each step is a small card with a label and one-line description.
Used for: data wrangling slides, merging datasets.

### `layout-warning`
Title at top. 3–5 warning cards in a grid, each with a coral left-border accent, icon, and short text. Overall background: slightly warm/pink tint.
Used for: common traps slides.

### `layout-activity`
Title at top. Centered call-to-action card with description of the hands-on activity. Link or instruction text below.
Used for: final slide introducing Part 2.

---

## INTERACTIVE COMPONENT SPECS

These are the key interactive elements that make this deck special. **Each interactive component simulates an Excel function in real time.** The user edits inputs and sees the output change immediately.

### General Rules for All Interactive Components

1. **Container**: bordered box (`2px solid var(--orange-brand)`, `border-radius: 8px`, `padding: 1.5rem`, `background: white`)
2. **Inputs**: styled text inputs or dropdowns with `font-family: monospace`, `font-size: 1.1rem`, `border: 1px solid #ccc`, `border-radius: 4px`, `padding: 0.4rem 0.6rem`
3. **Output**: displayed in a result box with `background: var(--code-bg)`, `color: var(--green-correct)`, `font-family: monospace`, `font-size: 1.3rem`, `padding: 0.5rem 1rem`, `border-radius: 6px`
4. **Labels**: small labels above each input field in `--mid-text`, `font-size: 0.85rem`, uppercase
5. **Instant update**: output recalculates on every `input` event (no submit button needed)
6. **Error display**: if inputs are invalid, show error message in `--coral-mistake` in the output box
7. **Highlight behavior**: when relevant, highlight the portion of the input string that the function is operating on using a `<mark>` tag with `background: rgba(240, 155, 26, 0.3)`

---

### Interactive: `if-simulator`
**Used on:** Slide 6 (IF + Nested IF)

**Layout:**
```
┌──────────────────────────────────────────────────┐
│  IF Function Simulator                           │
│                                                  │
│  VALUE:        [ 75      ]                       │
│  CONDITION:    [ >= ] [ 60 ]                     │
│  IF TRUE:      [ "Pass"  ]                       │
│  IF FALSE:     [ "Fail"  ]                       │
│                                                  │
│  Formula:  =IF(75 >= 60, "Pass", "Fail")         │
│  Result:   ┌────────────┐                        │
│            │  "Pass"  ✓ │                        │
│            └────────────┘                        │
│                                                  │
│  The condition 75 >= 60 evaluates to TRUE        │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- `VALUE` input: a number (default: `75`)
- `CONDITION` operator: dropdown with `>`, `>=`, `<`, `<=`, `=`, `<>` (default: `>=`)
- `CONDITION` threshold: a number (default: `60`)
- `IF TRUE` input: text (default: `"Pass"`)
- `IF FALSE` input: text (default: `"Fail"`)
- The formula display updates live: `=IF({value} {op} {threshold}, {true_val}, {false_val})`
- The result box shows the evaluated output
- Below the result: one-line explanation, e.g., "The condition 75 >= 60 evaluates to TRUE"

---

### Interactive: `countifs-simulator`
**Used on:** Slide 7 (COUNTIFS)

**Layout:**
```
┌──────────────────────────────────────────────────┐
│  COUNTIFS Simulator                              │
│                                                  │
│  Sample Data:                                    │
│  ┌──────────┬────────┬────────┐                  │
│  │ Region   │ Status │ Sales  │                  │
│  ├──────────┼────────┼────────┤                  │
│  │ West     │ Active │ 500    │  ← highlighted   │
│  │ East     │ Active │ 300    │                  │
│  │ West     │ Closed │ 200    │                  │
│  │ West     │ Active │ 450    │  ← highlighted   │
│  │ East     │ Closed │ 100    │                  │
│  └──────────┴────────┴────────┘                  │
│                                                  │
│  CRITERIA 1: Region = [ West ▼ ]                 │
│  CRITERIA 2: Status = [ Active ▼ ]               │
│                                                  │
│  =COUNTIFS(Region, "West", Status, "Active")     │
│  Result: 2                                       │
│                                                  │
│  2 rows match BOTH criteria (highlighted above)  │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- Hard-coded 5-row sample table (Region, Status, Sales)
- Two dropdown criteria filters (Region: West/East, Status: Active/Closed)
- Matching rows get highlighted with `background: rgba(240, 155, 26, 0.15)` and a left-border accent
- Formula display updates live
- Result shows count of matching rows
- Non-matching rows are slightly faded (`opacity: 0.4`)

---

### Interactive: `sumifs-simulator`
**Used on:** Slide 8 (SUMIFS)

**Identical table to COUNTIFS** but:
- Instead of counting, it sums the `Sales` column for matching rows
- Formula: `=SUMIFS(Sales, Region, "West", Status, "Active")`
- Result shows the sum (e.g., `950`)
- Matching rows highlighted; Sales values in those rows shown in bold green

---

### Interactive: `vlookup-simulator`
**Used on:** Slide 9 (VLOOKUP)

**Layout:**
```
┌──────────────────────────────────────────────────┐
│  VLOOKUP Simulator                               │
│                                                  │
│  Lookup Table:                                   │
│  ┌──────────┬────────────┬────────┐              │
│  │ Emp ID   │ Name       │ Dept   │              │
│  ├──────────┼────────────┼────────┤              │
│  │ E001     │ Alice Wong │ Sales  │              │
│  │ E002     │ Bob Chen   │ Ops    │  ← found     │
│  │ E003     │ Carol Li   │ HR     │              │
│  │ E004     │ Dave Kim   │ Sales  │              │
│  └──────────┴────────────┴────────┘              │
│                                                  │
│  LOOKUP VALUE:  [ E002    ]                      │
│  COL INDEX:     [ 3 ▼ ]  (1=ID, 2=Name, 3=Dept) │
│                                                  │
│  =VLOOKUP("E002", table, 3, FALSE)              │
│                                                  │
│  Step 1: Search column 1 for "E002" → Row 2      │
│  Step 2: Return column 3 of that row → "Ops"     │
│                                                  │
│  Result: "Ops"                                   │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- Hard-coded 4-row employee table
- `LOOKUP VALUE` text input (default: `E002`)
- `COL INDEX` dropdown: 1, 2, or 3
- The matching row is highlighted
- The lookup column (col 1) has a left-border accent in `--orange-brand`
- The return column has a top-border accent in `--green-correct`
- The return cell is highlighted in green
- Step-by-step explanation updates: "Search column 1 for '{value}' → Row {n}" then "Return column {col_index} of that row → '{result}'"
- If lookup value not found: show "Not Found" in `--coral-mistake`

---

### Interactive: `index-match-simulator`
**Used on:** Slides 10–12 (INDEX, MATCH, combined)

This is a **three-mode component** with tabs: `MATCH only`, `INDEX only`, `INDEX + MATCH`

**Tab 1: MATCH only**
```
┌──────────────────────────────────────────────────┐
│  [MATCH only] [INDEX only] [INDEX + MATCH]       │
│                                                  │
│  Array: [ "Sales", "Ops", "HR", "Finance" ]      │
│                                                  │
│  LOOKUP VALUE: [ Ops  ]                          │
│                                                  │
│  =MATCH("Ops", array, 0)                        │
│                                                  │
│  ┌────────┬────────┬────────┬─────────┐          │
│  │ Sales  │  Ops   │  HR    │ Finance │          │
│  │ pos 1  │ pos 2  │ pos 3  │ pos 4   │          │
│  └────────┴────────┴────────┴─────────┘          │
│               ↑ match found                      │
│                                                  │
│  Result: 2  (position in the array)              │
└──────────────────────────────────────────────────┘
```

**Tab 2: INDEX only**
```
│  Array: [ 500, 300, 200, 150 ]                   │
│                                                  │
│  ROW NUMBER: [ 2 ]                               │
│                                                  │
│  =INDEX(array, 2)                                │
│                                                  │
│  ┌──────┬──────┬──────┬──────┐                   │
│  │ 500  │ 300  │ 200  │ 150  │                   │
│  │ [1]  │ [2]  │ [3]  │ [4]  │                   │
│  └──────┴──────┴──────┴──────┘                   │
│            ↑ selected                            │
│                                                  │
│  Result: 300  (value at position 2)              │
```

**Tab 3: INDEX + MATCH combined**
```
│  Table:                                          │
│  ┌────────────┬────────┐                         │
│  │ Department │ Budget │                         │
│  ├────────────┼────────┤                         │
│  │ Sales      │ 500    │                         │
│  │ Ops        │ 300    │  ← match + return       │
│  │ HR         │ 200    │                         │
│  │ Finance    │ 150    │                         │
│  └────────────┴────────┘                         │
│                                                  │
│  LOOKUP: [ Ops ]                                 │
│                                                  │
│  =INDEX(Budget, MATCH("Ops", Department, 0))     │
│                                                  │
│  Step 1: MATCH finds "Ops" at position 2         │
│  Step 2: INDEX returns Budget[2] → 300           │
│                                                  │
│  Result: 300                                     │
```

**Behavior across all tabs:**
- Matched/selected cells highlighted
- Position indicators shown below each cell
- Step-by-step trace updates live
- Animate the highlight moving when input changes (brief 200ms transition)

---

### Interactive: `text-function-simulator`
**Used on:** Slide 13 (LEFT, RIGHT, MID)

**Layout:**
```
┌──────────────────────────────────────────────────┐
│  Text Extraction Simulator                       │
│                                                  │
│  INPUT STRING:  [ PROD-2024-XL ]                 │
│                                                  │
│  Character map:                                  │
│  ┌─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬──┬──┬──┬──┐             │
│  │P│R│O│D│-│2│0│2│4│-│X │L │  │  │             │
│  │1│2│3│4│5│6│7│8│9│10│11│12│  │  │             │
│  └─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴──┴──┴──┴──┘             │
│                                                  │
│  FUNCTION:  ( LEFT )  ( RIGHT )  ( MID )         │
│                                                  │
│  [If LEFT selected:]                             │
│  NUM CHARS: [ 4 ]                                │
│  =LEFT("PROD-2024-XL", 4)                       │
│  Characters 1–4 highlighted → Result: "PROD"     │
│                                                  │
│  [If MID selected:]                              │
│  START: [ 6 ]  NUM CHARS: [ 4 ]                  │
│  =MID("PROD-2024-XL", 6, 4)                     │
│  Characters 6–9 highlighted → Result: "2024"     │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- Input string: editable text input (default: `PROD-2024-XL`)
- Character map: each character displayed in its own box with position number below
- Three toggle buttons to switch between LEFT, RIGHT, MID
- For LEFT: one input (`num_chars`), highlights positions 1 through `num_chars`
- For RIGHT: one input (`num_chars`), highlights last `num_chars` positions
- For MID: two inputs (`start_num`, `num_chars`), highlights `start_num` through `start_num + num_chars - 1`
- Highlighted characters: `background: var(--orange-brand)`, `color: white`
- Non-highlighted characters: `background: var(--ice-bg)`, `color: var(--mid-text)`
- Result updates instantly

---

### Interactive: `concat-simulator`
**Used on:** Slide 14 (CONCATENATE)

```
┌──────────────────────────────────────────────────┐
│  CONCATENATE Simulator                           │
│                                                  │
│  PART 1: [ Hello  ]                              │
│  PART 2: [        ]  (space)                     │
│  PART 3: [ World  ]                              │
│  + Add another part                              │
│                                                  │
│  =CONCATENATE("Hello", " ", "World")             │
│                                                  │
│  Result: ┌──────────────────┐                    │
│          │  Hello World     │                    │
│          └──────────────────┘                    │
│  Each part shown in a different color band       │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- 3 input fields by default (can add up to 5 with an "+ Add part" button)
- Result string is displayed with each input's contribution shown as a differently-colored segment (use the palette colors cyclically)
- Formula updates live

---

### Interactive: `len-trim-simulator`
**Used on:** Slide 15 (LEN + TRIM)

```
┌──────────────────────────────────────────────────┐
│  LEN & TRIM Simulator                            │
│                                                  │
│  INPUT:  [   Hello   World   ]                   │
│                                                  │
│  Before TRIM:                                    │
│  "   Hello   World   "                           │
│  LEN = 21                                        │
│  [spaces shown as · dots for visibility]         │
│                                                  │
│  After TRIM:                                     │
│  "Hello World"                                   │
│  LEN = 11                                        │
│                                                  │
│  TRIM removed 10 extra space characters          │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- Text input that preserves whitespace
- Display spaces as visible `·` dots in a monospace font
- Show LEN before and after TRIM
- Highlight removed spaces in coral/red
- Show count of spaces removed

---

### Interactive: `substitute-replace-simulator`
**Used on:** Slide 16 (SUBSTITUTE + REPLACE)

**Two-panel comparison component:**

```
┌─────────────────────────┬─────────────────────────┐
│  SUBSTITUTE             │  REPLACE                 │
│  (replaces by content)  │  (replaces by position)  │
│                         │                          │
│  TEXT: [ 2024-01-15 ]   │  TEXT: [ 2024-01-15 ]    │
│  OLD:  [ - ]            │  START: [ 5 ]            │
│  NEW:  [ / ]            │  NUM:   [ 1 ]            │
│                         │  NEW:   [ / ]            │
│                         │                          │
│  =SUBSTITUTE(           │  =REPLACE(               │
│    "2024-01-15",        │    "2024-01-15",          │
│    "-", "/")            │    5, 1, "/")             │
│                         │                          │
│  Result: 2024/01/15     │  Result: 2024/01-15      │
│  (ALL "-" replaced)     │  (only position 5)       │
│                         │                          │
│  ⚠️ Key difference:     │                          │
│  SUBSTITUTE finds ALL   │  REPLACE targets ONE     │
│  matches by content     │  specific position       │
└─────────────────────────┴─────────────────────────┘
```

**Behavior:**
- Both panels share the same TEXT input (synced)
- SUBSTITUTE: highlight all occurrences of OLD text in the original string
- REPLACE: highlight only the characters at the specified position range
- Results update live
- Key difference callout always visible at bottom

---

### Interactive: `find-search-simulator`
**Used on:** Slide 17 (FIND + SEARCH)

```
┌──────────────────────────────────────────────────┐
│  FIND vs SEARCH                                  │
│                                                  │
│  TEXT:     [ Hello World ]                       │
│  FIND_ME:  [ world ]                             │
│                                                  │
│  ┌─────────────────┬─────────────────────┐       │
│  │ FIND             │ SEARCH              │       │
│  │ (case-sensitive)  │ (case-insensitive) │       │
│  │                   │                    │       │
│  │ Result: ERROR ✗   │ Result: 7 ✓        │       │
│  │ "world" ≠ "World" │ matches "World"   │       │
│  └─────────────────┴─────────────────────┘       │
│                                                  │
│  Character map with position highlight for       │
│  SEARCH match (positions 7–11)                   │
└──────────────────────────────────────────────────┘
```

**Behavior:**
- Two inputs: TEXT and FIND_ME
- Side-by-side results for FIND (case-sensitive) and SEARCH (case-insensitive)
- If FIND fails due to case mismatch: show "ERROR" in coral with explanation
- If SEARCH succeeds: show position and highlight matched characters in the character map
- Character map (same style as text extraction simulator)

---

## SLIDE-BY-SLIDE DEFINITIONS

Each slide specifies: `id`, `layout`, `section`, `title`, `objective`, `content`, `interactive` (if any), `exam_tip`, `common_mistake`, `speaker_notes`.

---

### SLIDE 0 — Title Slide

```yaml
id: 0
layout: layout-hero
section: null
title: "COMM 205 Exam B Review"
subtitle: "Excel + R — Functions, Wrangling, and Exam Patterns"
objective: Set the scope and establish a clean, confident opening tone.
content:
  - Course: COMM 205 — Introduction to Management Information Systems
  - Term: 2025W2
  - Exam B covers Lectures 10–25 (Excel + R only)
  - Worth 40% of your final grade
visual_notes: >
  Large centered title. Subtitle below in lighter weight.
  Optional subtle grid/spreadsheet motif in the background (very faint).
  Small "UBC Sauder" or course label at bottom.
interactive: null
speaker_notes: >
  Open by saying: "This session is focused only on the Excel and R portion of Exam B.
  We won't cover anything from Part A."
```

---

### SLIDE 1 — Land Acknowledgement

```yaml
id: 1
layout: layout-hero
section: null
title: "Land Acknowledgement"
objective: Respectful acknowledgement of Musqueam territory.
content:
  text: >
    UBC's Point Grey Campus is located on the traditional, ancestral, and unceded
    territory of the xʷməθkʷəy̓əm (Musqueam) people.
visual_notes: >
  Centered text. Understated typography. Plenty of whitespace.
  No decorative elements — keep this respectful and clean.
interactive: null
speaker_notes: >
  Read this aloud. Pause briefly before moving on.
```

---

### SLIDE 2 — Who Am I?

```yaml
id: 2
layout: layout-intro
section: null
title: "Who am I?"
objective: Establish credibility and approachability.
content:
  - Presenter name and short bio
  - Why I'm interested in teaching this material
  - Brief mention of relevant experience
visual_notes: >
  Left-aligned text with a friendly tone.
  Optional: small photo or avatar on the right side.
  Keep it brief — 4–5 lines max.
interactive: null
speaker_notes: >
  Keep this under 60 seconds. Students want to get to the content.
  Mention that you've been through this course and understand their position.
```

---

### SLIDE 3 — Overview & Housekeeping

```yaml
id: 3
layout: layout-intro
section: null
title: "Overview & Housekeeping"
objective: Frame the session structure and set expectations.
content:
  items:
    - label: "Access these slides"
      detail: "bit.ly/[shortlink] — follow along on your own device"
    - label: "This session has two parts"
      detail: null
    - label: "PART 1: Lecture-style review"
      detail: "We'll walk through every Excel function and R concept on the exam"
    - label: "PART 2: Hands-on mini-projects"
      detail: "You'll practice with real examples in Excel and R"
  tips:
    - "You don't need to memorize every slide — focus on patterns"
    - "If something is confusing, flag it — we'll revisit during Part 2"
    - "The interactive demos on each slide let you experiment live"
visual_notes: >
  Clean numbered or labeled list. Cards for each part.
  Bitly link should be large and prominent.
interactive: null
speaker_notes: >
  Share the bitly link verbally. Give students 30 seconds to open it.
  Emphasize that Part 2 is where things really click.
```

---

### SLIDE 4 — Excel Overview

```yaml
id: 4
layout: layout-hero
section: "EXCEL"
section_color: "--excel-green"
title: "Excel Review"
subtitle: "Lectures 10–16 · 7 function families"
objective: Introduce the Excel block and set a roadmap.
content:
  roadmap_cards:
    - icon: "🔀"
      label: "Conditionals"
      functions: "AND, OR, IF, nested IF"
    - icon: "📊"
      label: "Conditional Aggregation"
      functions: "COUNTIFS, SUMIFS"
    - icon: "🔍"
      label: "Lookups"
      functions: "VLOOKUP, INDEX, MATCH"
    - icon: "✂️"
      label: "Text Extraction"
      functions: "LEFT, RIGHT, MID, CONCATENATE"
    - icon: "🧹"
      label: "Text Cleanup"
      functions: "LEN, TRIM, SUBSTITUTE, REPLACE"
    - icon: "🔎"
      label: "Text Search"
      functions: "FIND, SEARCH"
visual_notes: >
  6-card grid layout. Each card has an emoji icon, label, and function names in monospace.
  Background: subtle green tint (`--excel-green` at 5% opacity).
interactive: null
speaker_notes: >
  Tell students: "For Excel questions, the first step is always identifying
  which function family the question is asking about. This roadmap helps you do that."
```

---

### SLIDE 5 — AND & OR

```yaml
id: 5
layout: layout-compare
section: "EXCEL"
title: "Conditionals: AND & OR"
objective: Explain the two logical operators that are building blocks for IF statements.
content:
  left:
    heading: "AND( )"
    explanation: "Returns TRUE only if ALL conditions are true"
    syntax: "=AND(condition1, condition2, ...)"
    example: "=AND(score >= 50, attendance >= 80)"
    analogy: "Think of a checklist — every box must be checked ✓"
    truth_table:
      - [TRUE, TRUE, "→ TRUE"]
      - [TRUE, FALSE, "→ FALSE"]
      - [FALSE, TRUE, "→ FALSE"]
      - [FALSE, FALSE, "→ FALSE"]
  right:
    heading: "OR( )"
    explanation: "Returns TRUE if ANY condition is true"
    syntax: "=OR(condition1, condition2, ...)"
    example: "=OR(dept = \"Sales\", dept = \"Marketing\")"
    analogy: "Think of a door with multiple keys — any one key opens it 🔑"
    truth_table:
      - [TRUE, TRUE, "→ TRUE"]
      - [TRUE, FALSE, "→ TRUE"]
      - [FALSE, TRUE, "→ TRUE"]
      - [FALSE, FALSE, "→ FALSE"]
  key_difference: "AND = all must be true · OR = at least one must be true"
interactive: null
exam_tip: "When you see 'both' or 'all' in a question → AND. When you see 'either' or 'any' → OR."
common_mistake: "Confusing AND with OR. If even one condition is FALSE, AND returns FALSE."
speaker_notes: >
  Use the analogy: AND is like a security checkpoint where you need ALL credentials.
  OR is like a VIP list where any matching name gets you in.
```

---

### SLIDE 6 — IF + Nested IF

```yaml
id: 6
layout: layout-interactive
section: "EXCEL"
title: "IF & Nested IF"
objective: Show how IF makes decisions and how nesting handles multiple outcomes.
content:
  explanation: >
    IF checks a condition and returns one value if true, another if false.
    Nested IF chains multiple conditions together for more categories.
  syntax:
    basic: "=IF(condition, value_if_true, value_if_false)"
    nested: "=IF(score>=90, \"A\", IF(score>=80, \"B\", IF(score>=70, \"C\", \"F\")))"
  key_insight: >
    Read nested IFs from the OUTSIDE in. The first condition that is TRUE wins.
interactive: "if-simulator"
exam_tip: "On the exam, trace through nested IFs by testing each condition in order. Stop at the first TRUE."
common_mistake: "Mismatched parentheses in nested IFs. Count your opening and closing parens — they must match."
speaker_notes: >
  Walk through the interactive demo. Change the value to 50 to show "Fail",
  then to 75 to show "Pass". Ask students to predict before revealing.
  For nested IF: explain that Excel evaluates left to right and stops at the first TRUE.
```

---

### SLIDE 7 — COUNTIFS

```yaml
id: 7
layout: layout-interactive
section: "EXCEL"
title: "COUNTIFS"
objective: Count rows that match multiple criteria simultaneously.
content:
  explanation: >
    COUNTIFS counts how many rows satisfy ALL of the given criteria.
    Each criterion is a pair: a range to check and a value to match.
  syntax: "=COUNTIFS(criteria_range1, criteria1, criteria_range2, criteria2, ...)"
  key_insight: >
    Criteria work like AND — a row must match ALL criteria to be counted.
    The ranges must all be the same size.
interactive: "countifs-simulator"
exam_tip: "COUNTIFS always returns a whole number. If you're getting decimals, you probably want SUMIFS."
common_mistake: "Forgetting that criteria ranges must be the same size and shape."
speaker_notes: >
  Use the demo to show: count West + Active, then switch to East + Closed.
  Point out how the highlighted rows change.
  Emphasize that COUNTIFS is like COUNTIF but for multiple conditions.
```

---

### SLIDE 8 — SUMIFS

```yaml
id: 8
layout: layout-interactive
section: "EXCEL"
title: "SUMIFS"
objective: Sum values from rows that match multiple criteria.
content:
  explanation: >
    SUMIFS adds up values from one column, but only for rows that match ALL criteria.
  syntax: "=SUMIFS(sum_range, criteria_range1, criteria1, criteria_range2, criteria2, ...)"
  key_insight: >
    The SUM RANGE comes FIRST in SUMIFS — this is different from COUNTIFS where there is no sum range.
  comparison_to_countifs: >
    COUNTIFS counts matching rows. SUMIFS totals a specific column for matching rows.
interactive: "sumifs-simulator"
exam_tip: "Argument order trap: in SUMIFS, the sum_range is the FIRST argument. In COUNTIFS, there is no sum_range."
common_mistake: "Putting criteria_range before sum_range. The sum_range MUST be first in SUMIFS."
speaker_notes: >
  Show that with the same criteria (West + Active), COUNTIFS gives 2 but SUMIFS gives 950.
  Hammer home the argument order difference — this is one of the most common exam mistakes.
```

---

### SLIDE 9 — VLOOKUP

```yaml
id: 9
layout: layout-interactive
section: "EXCEL"
title: "VLOOKUP"
objective: Look up a value in the first column of a table and return a value from another column.
content:
  explanation: >
    VLOOKUP searches for a value in the FIRST (leftmost) column of a table,
    then returns a value from a specified column in the same row.
  syntax: "=VLOOKUP(lookup_value, table_array, col_index_num, [range_lookup])"
  parameters:
    - name: "lookup_value"
      desc: "What you're searching for"
    - name: "table_array"
      desc: "The table to search in"
    - name: "col_index_num"
      desc: "Which column to return (1 = first column)"
    - name: "range_lookup"
      desc: "FALSE = exact match (almost always what you want)"
  key_insight: >
    VLOOKUP can only look LEFT to RIGHT. The lookup column must be the first column of your table.
interactive: "vlookup-simulator"
exam_tip: "Always use FALSE for exact match unless the question specifically asks for approximate. col_index_num starts at 1, not 0."
common_mistake: "Using the wrong col_index_num. Column 1 is the lookup column itself, not the first return column."
speaker_notes: >
  Demo: look up E002 → show Ops. Then change col_index to 2 → show "Bob Chen".
  Then type E005 (doesn't exist) → show the error.
  Ask: "What if the column you want to return is to the LEFT of the lookup column?"
  Answer: You can't — that's why we need INDEX + MATCH.
```

---

### SLIDE 10 — INDEX

```yaml
id: 10
layout: layout-interactive
section: "EXCEL"
title: "INDEX"
objective: Return a value at a specific position in a range.
content:
  explanation: >
    INDEX returns the value at a given row (and optionally column) position in a range.
    Think of it as: "Give me the item at position N."
  syntax: "=INDEX(array, row_num)"
  analogy: >
    Like a numbered coat check: give the ticket number, get the coat.
interactive: "index-match-simulator"
interactive_default_tab: "INDEX only"
exam_tip: "INDEX doesn't search for anything — it just retrieves by position. The searching part is MATCH's job."
common_mistake: "Confusing INDEX with VLOOKUP. INDEX doesn't search — it needs to be told WHERE to look."
speaker_notes: >
  Show the INDEX-only tab. Enter position 1 → 500. Position 3 → 200.
  Emphasize that INDEX is simple on its own — it's powerful when combined with MATCH.
```

---

### SLIDE 11 — MATCH

```yaml
id: 11
layout: layout-interactive
section: "EXCEL"
title: "MATCH"
objective: Find the position of a value within a range.
content:
  explanation: >
    MATCH searches for a value in a range and returns its POSITION (not the value itself).
    Think of it as: "Where is this item in the list?"
  syntax: "=MATCH(lookup_value, lookup_array, match_type)"
  parameters:
    - name: "match_type"
      desc: "Use 0 for exact match (most common on exams)"
  analogy: >
    Like searching a numbered list: "What position is 'Ops' in?" → Answer: 2
interactive: "index-match-simulator"
interactive_default_tab: "MATCH only"
exam_tip: "MATCH returns a POSITION NUMBER, not a value. To get the actual value, you need INDEX."
common_mistake: "Forgetting match_type = 0 for exact match. Without it, you may get unexpected results."
speaker_notes: >
  Show the MATCH-only tab. Search for "Sales" → 1, "HR" → 3.
  Ask: "What does MATCH give you?" → A number (position).
  "What does VLOOKUP give you?" → A value from another column.
  "So how do we combine finding a position AND getting a value?" → INDEX + MATCH.
```

---

### SLIDE 12 — INDEX + MATCH Combined

```yaml
id: 12
layout: layout-interactive
section: "EXCEL"
title: "INDEX + MATCH Together"
objective: Show how INDEX and MATCH combine to create flexible lookups.
content:
  explanation: >
    MATCH finds the position. INDEX retrieves the value at that position.
    Together, they do what VLOOKUP does — but better:
  advantages_over_vlookup:
    - "Can look up in ANY direction (not just left-to-right)"
    - "Lookup column doesn't need to be the first column"
    - "More flexible for complex tables"
  syntax: "=INDEX(return_range, MATCH(lookup_value, lookup_range, 0))"
  reading_guide: >
    Read from the inside out:
    1. MATCH finds the position of the lookup value
    2. INDEX uses that position to return the value from the return range
interactive: "index-match-simulator"
interactive_default_tab: "INDEX + MATCH"
exam_tip: "If a question gives you a table where the lookup column is NOT the first column, use INDEX + MATCH."
common_mistake: "Using the wrong range for MATCH vs INDEX. MATCH searches one range, INDEX returns from a DIFFERENT range."
speaker_notes: >
  Show the INDEX + MATCH tab. Look up "Ops" → get 300.
  Then ask: "Could VLOOKUP do this?" → Yes, in this case, because Department is column 1.
  "But what if Budget was column 1 and Department was column 2?" → VLOOKUP would fail. INDEX + MATCH would still work.
```

---

### SLIDE 13 — LEFT, RIGHT, MID

```yaml
id: 13
layout: layout-interactive
section: "EXCEL"
title: "Text Extraction: LEFT, RIGHT, MID"
objective: Extract specific characters from a text string by position.
content:
  functions:
    - name: "LEFT"
      syntax: "=LEFT(text, num_chars)"
      desc: "Extract characters from the start"
    - name: "RIGHT"
      syntax: "=RIGHT(text, num_chars)"
      desc: "Extract characters from the end"
    - name: "MID"
      syntax: "=MID(text, start_num, num_chars)"
      desc: "Extract characters from any position"
  key_insight: >
    Think of your text as a numbered row of boxes. These functions highlight a segment of that row.
interactive: "text-function-simulator"
exam_tip: "MID's start_num begins at 1, not 0. Position 1 is the first character."
common_mistake: "Off-by-one errors with MID. If you want characters 6–9, use MID(text, 6, 4), not MID(text, 6, 3)."
speaker_notes: >
  Demo with "PROD-2024-XL":
  LEFT(text, 4) → "PROD"
  RIGHT(text, 2) → "XL"
  MID(text, 6, 4) → "2024"
  Have students count the characters along with the character map.
```

---

### SLIDE 14 — CONCATENATE

```yaml
id: 14
layout: layout-interactive
section: "EXCEL"
title: "CONCATENATE"
objective: Join multiple text strings into one.
content:
  explanation: >
    CONCATENATE glues pieces of text together into a single string.
    Each piece is called an argument — they are joined in order.
  syntax: "=CONCATENATE(text1, text2, text3, ...)"
  key_insight: >
    Spaces are NOT added automatically. If you want a space between words,
    you must include " " as a separate argument.
  example:
    formula: '=CONCATENATE("Jane", " ", "Doe")'
    result: "Jane Doe"
interactive: "concat-simulator"
exam_tip: "If the result has no spaces between words, you forgot to add \" \" as an argument."
common_mistake: "Forgetting the space separator. CONCATENATE(\"Hello\", \"World\") gives \"HelloWorld\", not \"Hello World\"."
speaker_notes: >
  Demo: type first name, space, last name. Show how each part gets a different color band.
  Then remove the space argument to show "HelloWorld" — students see the problem immediately.
```

---

### SLIDE 15 — LEN + TRIM

```yaml
id: 15
layout: layout-interactive
section: "EXCEL"
title: "LEN & TRIM"
objective: Count characters and clean up unwanted spaces.
content:
  functions:
    - name: "LEN"
      syntax: "=LEN(text)"
      desc: "Returns the number of characters in a string (including spaces)"
    - name: "TRIM"
      syntax: "=TRIM(text)"
      desc: "Removes extra spaces — leading, trailing, and reduces internal multiple spaces to single spaces"
  key_insight: >
    Imported data often has invisible extra spaces that can break lookups and comparisons.
    TRIM is your first cleanup tool.
  example:
    before: '"   Hello   World   "'
    before_len: 21
    after: '"Hello World"'
    after_len: 11
interactive: "len-trim-simulator"
exam_tip: "If a VLOOKUP isn't finding a match, extra spaces might be the culprit. TRIM both the lookup value and the table."
common_mistake: "Assuming LEN only counts visible characters. Spaces count too!"
speaker_notes: >
  Type "   Hello   World   " into the demo. Show the dots representing spaces.
  Show LEN = 21 before, 11 after TRIM. Ask: "Where did those 10 characters go?"
```

---

### SLIDE 16 — SUBSTITUTE + REPLACE

```yaml
id: 16
layout: layout-interactive
section: "EXCEL"
title: "SUBSTITUTE vs REPLACE"
objective: Understand the difference between replacing by content vs by position.
content:
  comparison:
    substitute:
      label: "SUBSTITUTE"
      method: "Replaces by CONTENT (what it says)"
      syntax: "=SUBSTITUTE(text, old_text, new_text)"
      behavior: "Finds ALL occurrences of old_text and replaces them"
    replace:
      label: "REPLACE"
      method: "Replaces by POSITION (where it is)"
      syntax: "=REPLACE(text, start_num, num_chars, new_text)"
      behavior: "Replaces characters at a specific position range"
  key_difference: >
    SUBSTITUTE: "Replace every dash with a slash"
    REPLACE: "Replace the character at position 5 with a slash"
interactive: "substitute-replace-simulator"
exam_tip: "If the question says 'replace all occurrences' → SUBSTITUTE. If it says 'replace characters at position X' → REPLACE."
common_mistake: "Thinking SUBSTITUTE only replaces the first occurrence. By default, it replaces ALL."
speaker_notes: >
  Use the demo with "2024-01-15".
  SUBSTITUTE replaces ALL dashes: "2024/01/15"
  REPLACE at position 5 for 1 char: "2024/01-15" (only the first dash)
  This visual difference is the key teaching moment.
```

---

### SLIDE 17 — FIND + SEARCH

```yaml
id: 17
layout: layout-interactive
section: "EXCEL"
title: "FIND vs SEARCH"
objective: Locate text within text and understand case sensitivity.
content:
  comparison:
    find:
      label: "FIND"
      syntax: "=FIND(find_text, within_text)"
      property: "Case-SENSITIVE"
      example: 'FIND("world", "Hello World") → ERROR'
    search:
      label: "SEARCH"
      syntax: "=SEARCH(find_text, within_text)"
      property: "Case-INSENSITIVE"
      example: 'SEARCH("world", "Hello World") → 7'
  key_difference: >
    Both return the starting position of the found text.
    FIND cares about uppercase/lowercase. SEARCH does not.
  when_to_use:
    - "FIND when case matters (e.g., matching product codes exactly)"
    - "SEARCH when case doesn't matter (e.g., finding a keyword regardless of capitalization)"
interactive: "find-search-simulator"
exam_tip: "This is a classic exam comparison. Remember: FIND is Fussy (case-sensitive). SEARCH is Soft (case-insensitive)."
common_mistake: "Forgetting that both return a POSITION NUMBER, not TRUE/FALSE."
speaker_notes: >
  Demo with "Hello World" and searching for "world" (lowercase).
  FIND → ERROR. SEARCH → 7.
  Then change to "World" (uppercase W). Both succeed.
  The mnemonic: "FIND is Fussy, SEARCH is Soft."
```

---

### SLIDE 18 — R Programming Basics

```yaml
id: 18
layout: layout-concept
section: "R"
section_color: "--r-blue"
title: "R Programming Basics"
objective: Review the fundamentals of writing and reading R code.
content:
  concepts:
    - heading: "Variables & Assignment"
      code: 'x <- 10\nname <- "Alice"'
      explanation: 'Use <- to assign values to variables. Think of it as "x gets 10".'
    - heading: "Basic Operations"
      code: 'x + 5       # 15\nx * 2       # 20\nsqrt(x)     # 3.16...'
      explanation: "R works like a calculator. You can use +, -, *, /, and built-in functions."
    - heading: "Calling Functions"
      code: 'mean(c(10, 20, 30))  # 20\nlength(c(1, 2, 3))   # 3'
      explanation: "Functions take inputs in parentheses and return outputs."
    - heading: "The c() Function"
      code: 'numbers <- c(1, 2, 3, 4, 5)\nnames <- c("Alice", "Bob", "Carol")'
      explanation: 'c() combines values into a vector (a list of items). Think "c for combine."'
interactive: null
exam_tip: "R is case-sensitive. 'Name' and 'name' are different variables."
common_mistake: "Using = instead of <- for assignment. While = sometimes works, <- is the standard and what the course expects."
speaker_notes: >
  Keep this high-level. Students should be able to read basic R code and know what it does.
  Don't get into edge cases — focus on the patterns they'll see on the exam.
```

---

### SLIDE 19 — R Data Types: Numbers + Strings

```yaml
id: 19
layout: layout-concept
section: "R"
title: "Data Types: Numbers & Strings"
objective: Identify and work with numeric and character data types.
content:
  types:
    - name: "Numeric"
      examples: "42, 3.14, -7, 0"
      description: "Numbers you can do math with"
      code: 'x <- 42\nclass(x)  # "numeric"'
      operations: "Can add, subtract, multiply, divide, compare"
    - name: "Character (String)"
      examples: '"Hello", "COMM205", "42"'
      description: 'Text wrapped in quotes — even "42" is text if it has quotes'
      code: 'y <- "Hello"\nclass(y)  # "character"'
      operations: "Can concatenate, search, extract — but NOT do math"
  key_insight: >
    The same value can be different types: 42 (numeric) vs "42" (character).
    You cannot do math on "42" because R sees it as text.
  conversion:
    code: 'as.numeric("42")  # 42\nas.character(42)  # "42"'
interactive: null
exam_tip: "If a question shows a value in quotes, it's a character — even if it looks like a number."
common_mistake: 'Writing name <- Alice instead of name <- "Alice". Strings MUST have quotes.'
speaker_notes: >
  Emphasize the quotes rule. Show that "42" + 1 gives an error because "42" is text.
  This trips up a lot of students.
```

---

### SLIDE 20 — R Data Types: Booleans + Conditionals

```yaml
id: 20
layout: layout-concept
section: "R"
title: "Data Types: Booleans & Conditionals"
objective: Work with TRUE/FALSE values and conditional logic in R.
content:
  boolean_basics:
    code: 'is_student <- TRUE\nhas_paid <- FALSE\nclass(is_student)  # "logical"'
    explanation: "Logical values are either TRUE or FALSE (always uppercase, no quotes)"
  comparisons:
    code: '10 > 5     # TRUE\n10 == 10   # TRUE\n10 != 5    # TRUE\n"a" == "b"  # FALSE'
    operators:
      - ["==", "equal to"]
      - ["!=", "not equal to"]
      - [">", "greater than"]
      - ["<", "less than"]
      - [">=", "greater than or equal"]
      - ["<=", "less than or equal"]
  logical_operators:
    code: 'TRUE & FALSE   # FALSE (AND)\nTRUE | FALSE   # TRUE  (OR)\n!TRUE          # FALSE (NOT)'
    explanation: "& means AND, | means OR, ! means NOT — same logic as Excel's AND/OR"
interactive: null
exam_tip: "== checks equality (two equals signs). = is assignment. Mixing these up is a common error."
common_mistake: "Writing TRUE with quotes: \"TRUE\" is a character string, not a logical value."
speaker_notes: >
  Connect back to Excel: AND/OR in Excel work the same as &/| in R.
  The logic is identical — only the syntax is different.
```

---

### SLIDE 21 — R Data Frames

```yaml
id: 21
layout: layout-concept
section: "R"
title: "Data Frames"
objective: Understand how tabular data is stored and accessed in R.
content:
  explanation: >
    A data frame is R's version of a spreadsheet table.
    It has rows (observations) and columns (variables).
  creation:
    code: |
      df <- data.frame(
        Name = c("Alice", "Bob", "Carol"),
        Score = c(85, 92, 78),
        Pass = c(TRUE, TRUE, TRUE)
      )
  access_patterns:
    - pattern: "df$Name"
      result: '"Alice" "Bob" "Carol"'
      explanation: "Get one column by name (returns a vector)"
    - pattern: "df[1, ]"
      result: "Alice  85  TRUE"
      explanation: "Get one row by number"
    - pattern: 'df[2, "Score"]'
      result: "92"
      explanation: "Get a specific cell: row 2, column 'Score'"
    - pattern: "nrow(df)"
      result: "3"
      explanation: "Count the number of rows"
    - pattern: "ncol(df)"
      result: "3"
      explanation: "Count the number of columns"
  visual:
    description: "Show a mini table rendering of the data frame next to the code"
interactive: null
exam_tip: "df$Column gives you a vector. df[row, col] gives you specific cells. Know both access patterns."
common_mistake: "Forgetting the $ to access columns: writing df[Name] instead of df$Name."
speaker_notes: >
  Draw the connection to spreadsheets: a data frame IS a table.
  Columns = variables, Rows = observations.
  The $ is the most important accessor students need to know.
```

---

### SLIDE 22 — Data Wrangling I

```yaml
id: 22
layout: layout-workflow
section: "R"
title: "Data Wrangling I: Select & Filter"
objective: Review selecting columns and filtering rows.
content:
  explanation: >
    Data wrangling means transforming raw data into a useful format.
    The first two operations: pick which columns you want, and which rows you want.
  operations:
    - step: 1
      name: "select()"
      description: "Choose which COLUMNS to keep"
      code: 'select(df, Name, Score)'
      before: "Full table with all columns"
      after: "Table with only Name and Score columns"
    - step: 2
      name: "filter()"
      description: "Choose which ROWS to keep based on a condition"
      code: 'filter(df, Score >= 80)'
      before: "All rows"
      after: "Only rows where Score is 80 or higher"
  pipeline_intro: >
    These operations can be chained together using the pipe operator: %>%
    Read %>% as "and then..."
  chained_example:
    code: |
      df %>%
        select(Name, Score) %>%
        filter(Score >= 80)
    reading: 'Take df, AND THEN select Name and Score, AND THEN keep only rows where Score >= 80'
interactive: null
exam_tip: "select() works on COLUMNS. filter() works on ROWS. Don't mix them up."
common_mistake: "Using filter() to pick columns or select() to pick rows. Remember: select = columns, filter = rows."
speaker_notes: >
  The pipe operator %>% is critical. Read it aloud as "and then" every time.
  Show the transformation step by step: full table → selected columns → filtered rows.
```

---

### SLIDE 23 — Data Wrangling II

```yaml
id: 23
layout: layout-workflow
section: "R"
title: "Data Wrangling II: Mutate & Arrange"
objective: Create new columns and sort data.
content:
  operations:
    - step: 1
      name: "mutate()"
      description: "Create a NEW column based on existing columns"
      code: 'mutate(df, Grade = ifelse(Score >= 80, "Pass", "Fail"))'
      before: "Table with Name, Score"
      after: "Table with Name, Score, and new Grade column"
    - step: 2
      name: "arrange()"
      description: "Sort rows by a column's values"
      code: 'arrange(df, Score)          # ascending (low to high)\narrange(df, desc(Score))   # descending (high to low)'
      before: "Rows in original order"
      after: "Rows sorted by Score"
  chained_example:
    code: |
      df %>%
        mutate(Grade = ifelse(Score >= 80, "Pass", "Fail")) %>%
        arrange(desc(Score))
    reading: "Take df, AND THEN create a Grade column, AND THEN sort by Score (highest first)"
interactive: null
exam_tip: "mutate() ADDS a column — it doesn't remove existing ones. The original columns are still there."
common_mistake: "Forgetting desc() for descending sort. arrange(df, Score) sorts low-to-high by default."
speaker_notes: >
  mutate = create new columns. arrange = sort rows.
  Show the pipeline: add grade, then sort. Students should trace what the table looks like after each step.
```

---

### SLIDE 24 — Data Wrangling III

```yaml
id: 24
layout: layout-workflow
section: "R"
title: "Data Wrangling III: Group & Summarize"
objective: Aggregate data by groups and compute summary statistics.
content:
  explanation: >
    The most powerful wrangling pattern: split your data into groups,
    then calculate a summary for each group.
  operations:
    - step: 1
      name: "group_by()"
      description: "Split the data into groups based on a column"
      code: 'group_by(df, Department)'
      visual: "Rows are mentally grouped by Department — nothing visible changes yet"
    - step: 2
      name: "summarize() / summarise()"
      description: "Collapse each group into a single summary row"
      code: |
        df %>%
          group_by(Department) %>%
          summarize(
            Avg_Score = mean(Score),
            Count = n()
          )
      before: "Many rows per department"
      after: "One row per department with Avg_Score and Count"
  key_insight: >
    group_by() alone doesn't change the output. It sets up INVISIBLE groups.
    summarize() is what actually creates the summary table.
  common_functions_in_summarize:
    - ["mean()", "Average"]
    - ["sum()", "Total"]
    - ["n()", "Count of rows"]
    - ["min() / max()", "Smallest / largest"]
interactive: null
exam_tip: "group_by() + summarize() always go together. If you see group_by without summarize, something is probably missing."
common_mistake: "Forgetting group_by() before summarize(). Without it, you get one summary for the entire dataset instead of per group."
speaker_notes: >
  This is the hardest wrangling concept. Walk through it slowly.
  Show the three-step transformation: original → grouped (conceptually) → summarized.
  Use a concrete example: average score by department.
```

---

### SLIDE 25 — Merging Datasets

```yaml
id: 25
layout: layout-compare
section: "R"
title: "Merging Datasets"
objective: Combine two tables using a shared key column.
content:
  explanation: >
    When your data is split across two tables, you merge them on a shared column (the "key").
    This is like VLOOKUP in Excel — finding matching rows across tables.
  visual:
    description: >
      Show two mini tables side by side with arrows connecting matching key values,
      then a merged result table below.
    table_left:
      name: "Customers"
      columns: ["CustomerID", "Name"]
      rows:
        - ["C01", "Alice"]
        - ["C02", "Bob"]
        - ["C03", "Carol"]
    table_right:
      name: "Orders"
      columns: ["CustomerID", "Amount"]
      rows:
        - ["C01", 500]
        - ["C01", 300]
        - ["C02", 200]
    merged:
      columns: ["CustomerID", "Name", "Amount"]
      rows:
        - ["C01", "Alice", 500]
        - ["C01", "Alice", 300]
        - ["C02", "Bob", 200]
  code: |
    merge(customers, orders, by = "CustomerID")
    # or with dplyr:
    inner_join(customers, orders, by = "CustomerID")
  join_types:
    - name: "inner_join"
      desc: "Keep only rows with matches in BOTH tables"
    - name: "left_join"
      desc: "Keep all rows from left table, add matches from right"
    - name: "right_join"
      desc: "Keep all rows from right table, add matches from left"
    - name: "full_join"
      desc: "Keep all rows from both tables"
interactive: null
exam_tip: "The 'by' column must exist in BOTH tables. If the column names differ, you need by = c('left_name' = 'right_name')."
common_mistake: "Merging on the wrong key column. Always check: which column is shared between the two tables?"
speaker_notes: >
  Connect to VLOOKUP: merging is like doing a VLOOKUP for every row automatically.
  Show the visual: two tables → arrows on matching CustomerIDs → merged result.
  Note that C03 (Carol) disappears in inner_join because she has no orders.
```

---

### SLIDE 26 — Other R Commands

```yaml
id: 26
layout: layout-concept
section: "R"
title: "Other Useful R Commands"
objective: Quick reference for remaining utility commands from Lecture 24.
content:
  commands:
    - name: "head() / tail()"
      code: "head(df, 5)  # first 5 rows\ntail(df, 3)  # last 3 rows"
      desc: "Preview the beginning or end of a dataset"
    - name: "str()"
      code: "str(df)"
      desc: "Show the structure of a data frame — column names, types, and sample values"
    - name: "summary()"
      code: "summary(df)"
      desc: "Quick statistical summary (min, max, mean, etc.) for each column"
    - name: "is.na() / na.rm"
      code: "is.na(df$Score)            # check for missing values\nmean(df$Score, na.rm = TRUE) # ignore NAs in calculation"
      desc: "Detect and handle missing values"
    - name: "rename()"
      code: 'rename(df, StudentName = Name)'
      desc: "Change a column's name (new_name = old_name)"
  note: >
    This slide is a quick reference — you don't need to memorize every command.
    Focus on knowing WHAT each one does, so you can recognize it on the exam.
interactive: null
exam_tip: "str() shows structure, summary() shows statistics. Know the difference."
common_mistake: "In rename(), the order is new_name = old_name (new name goes on the LEFT)."
speaker_notes: >
  Go through these quickly — 10-15 seconds each. These are recognition items.
  Students should be able to read code using these commands and know what they do.
```

---

### SLIDE 27 — Introduce Hands-On Activity

```yaml
id: 27
layout: layout-activity
section: null
title: "Part 2: Hands-On Practice"
objective: Transition from lecture to interactive practice.
content:
  intro: >
    You've reviewed all the concepts. Now let's put them to work.
  activity_description: >
    We're going to build mini-projects using the functions and commands we just reviewed.
    Work through these at your own pace. Ask questions as you go.
  call_to_action: "Open your laptops — let's practice."
  closing_tips:
    - "If you can explain what a function does without looking at notes, you know it"
    - "If you can predict the output of a formula before running it, you're ready"
    - "Focus on the functions you found hardest during Part 1"
  motivational_close: >
    "Slow is smooth. Smooth is fast."
    Take your time on the exam. Read each question carefully.
    You've got this.
visual_notes: >
  Clean, decisive final slide. Large call-to-action text.
  Green accent color for the motivational close.
  No clutter — end strong.
interactive: null
speaker_notes: >
  This is the transition to Part 2. Give students a moment to open their laptops.
  Remind them: "The interactive demos on each slide are still available — you can go
  back to any slide and play with them during practice time."
```

---

## CONTENT WRITING RULES

### For All Slides

1. **One concept per slide.** Never combine two unrelated functions on one slide.
2. **Lead with what it does**, not the syntax. Students need to know WHEN to use something before HOW.
3. **Syntax in monospace**, always. Every formula, function name, or code snippet must be in `monospace`.
4. **Worked examples use business-school-friendly data**: student grades, product sales, employee records, customer IDs, campaign metrics. Never abstract CS examples.
5. **Exam tips** should answer: "What mistake would lose you marks on this exact question?"
6. **Common mistakes** should answer: "What do most students get wrong the first time?"
7. **Keep text short.** No slide should have more than ~120 words of body text. If it needs more, split into multiple cards or use the interactive component to carry the explanation.

### For Interactive Components

1. **Default values should tell a story.** Don't use random values — use defaults that produce a clear, understandable result (e.g., score 75 with threshold 60 → Pass).
2. **Instant feedback.** No submit buttons. Every input change immediately updates the output.
3. **Highlight the connection** between input and output visually (color-coded segments, animated arrows, highlighted cells).
4. **Error states are teaching moments.** When a lookup fails or a type is wrong, show a clear, helpful error message — not just "ERROR".

### For Code Blocks (R slides)

1. Use syntax highlighting: keywords in one color, strings in another, comments in gray.
2. Add inline comments (# ...) to explain each line.
3. Keep code blocks to 5 lines or fewer per block. If longer, break into multiple blocks with explanation between them.
4. Show the output/result directly below or beside the code.

### For Formula Display (Excel slides)

1. Show the generic syntax first (with parameter names).
2. Then show a concrete example with real values substituted in.
3. Color-code the arguments if possible: lookup_value in orange, table in blue, col_index in green.

---

## BUILD CHECKLIST

Before the deck is considered complete, verify:

- [ ] All 28 slides render correctly
- [ ] Keyboard navigation works (←, →, Space, Escape)
- [ ] Progress bar updates accurately
- [ ] Slide counter shows correct numbers
- [ ] All 9 interactive components work (inputs update outputs in real time)
- [ ] Interactive components handle edge cases (empty input, not-found values)
- [ ] All code blocks use monospace font at readable size
- [ ] Color palette matches the spec
- [ ] Responsive: displays cleanly at 1920×1080, 1280×720, and 1280×800
- [ ] File is a single index.html under 500KB
- [ ] No external dependencies except Google Fonts
- [ ] Can be opened directly in a browser (no build step)
- [ ] Can be deployed on Vercel as-is

---

## APPENDIX: EXAM SCOPE REFERENCE

From the COMM 205 syllabus (2025W2), Exam B covers Lectures 10–25:

```
Lecture 10: Excel Part I (IF; nested IF; AND; OR)
Lecture 11: Excel Part II (COUNTIFS; SUMIFS)
Lecture 12: Excel Part III (VLOOKUP)
Lecture 13: Excel Part IV (INDEX; MATCH)
Lecture 14: Excel Part V (LEFT; RIGHT; MID; CONCATENATE)
Lecture 15: Excel Part VI (LEN; TRIM; SUBSTITUTE; REPLACE)
Lecture 16: Excel Part VII (FIND; SEARCH)
Lecture 17: R Programming Part I (R programming basics)
Lecture 18: R Programming Part II (R data types)
Lecture 19: R Programming Part III (R Data frame)
Lecture 20: R Programming Part IV (Data Wrangling I)
Lecture 21: R Programming Part V (Data Wrangling II)
Lecture 22: R Programming Part VI (Data Wrangling III)
Lecture 23: R Programming Part VII (Merging datasets)
Lecture 24: R Programming Part VIII (Other commands)
Lecture 25: R Programming Review
```

Exam B is worth **40% of the final course grade**, administered in-person via Canvas with LockDown Browser. GenAI is prohibited during the exam.