# Rubric - m5a5 HAUDEX app (100 points)

The finale of the whole course: a small but complete HAUDEX app that ties Module
4 (screens, layout, styling) and Module 5 (state, input, lists, navigation)
together. Worth **100 points**, split into an automated half and a design/UX
half (40 + 60 = 100).

## Automated checks (40 pts, scored from the tests - not by hand)

| Check | Points |
| --- | --- |
| `student.json` is filled in | 5 |
| Lists the seed monsters | 7 |
| Has a FloatingActionButton to add a monster | 7 |
| The add button opens a form with a TextField | 7 |
| Tapping a monster opens its detail screen (keyed `detailType`) | 7 |
| The detail screen's Attack lowers HP and never goes negative | 7 |
| **Automated subtotal** | **40** |

## Design & UX rubric (60 pts, scored from the screenshot and code)

The AI scores ONLY this table. Judge the screenshot as a real mobile app.

| Criterion | Max | Excellent (full marks) | Satisfactory (~60-80%) | Needs work (~0-40%) |
| --- | --- | --- | --- | --- |
| Visual design & consistency | 14 | cohesive look across screens, sensible colour/spacing, type identity carried through | mostly consistent, some rough edges | inconsistent or unstyled |
| Home / list quality | 10 | clear, scrollable, each monster readable at a glance | works but plain | cramped or broken |
| Add flow (UX) | 10 | adding a monster is obvious and smooth; input validated | works but clunky | confusing or broken |
| Detail screen & battle feel | 10 | detail reads well; Attack gives clear feedback (HP bar/faint state) | functional but flat | token |
| Layout on a phone | 8 | nothing overflows; fits the device | minor issues | overflow / cut-off |
| Code organization | 8 | screens split into small widgets/files, well named, state where it belongs, no dead code | workable but monolithic | messy or duplicated |

Design rubric total: 60 points. **Automated 40 + design/UX 60 = 100.**

Notes for feedback: name the concept to revisit or ask a guiding question; never
hand over corrected code. Comment on the visual design (from the screenshot),
the UX of the flows, and how the code is organized (state placement, widget
breakdown). Keep it encouraging and at a beginner's level.
