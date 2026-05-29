# DIRECTION.md
## Terrarium — Game Jam Design Document
**Jam:** Major Jam: Wonder
**Limitation:** Locked In
**Engine:** Godot 4

---

## Concept

A tiny adventurer falls into a sealed glass terrarium that has been closed for centuries. The ecosystem inside has evolved in strange, isolated ways. The terrarium is divided into **chambers**, each sealed with a lock mechanism. You explore turn by turn, uncovering what this world became — and why it was sealed in the first place.

The ending is a **choice**: break the glass and destroy the world inside, or stay and become part of it.

---

## Theme Interpretation

"Locked In" operates on two levels:
- The player is physically **trapped inside** the terrarium with no clear escape
- Each chamber is **sealed behind a lock** that must be solved to progress

---

## Core Gameplay

**Turn-based roguelike rule:** the world only moves when you do.

This works for the setting because:
- Creatures behave like isolated, evolved fauna — predictable patterns that feel alien
- Lock puzzles reward thinking, not reaction speed
- The stillness between turns reinforces the feeling of a sealed, quiet world

**Each turn the player can:** move, interact, wait, or use an item.

---

## The Lock Mechanic

Each chamber seal is a **diegetic puzzle** — not a key hunt, but something that makes sense as part of the living ecosystem:

- Rearranging overgrown roots that have jammed a mechanism
- Coaxing a creature into position to press a pressure plate
- Redirecting moisture or light within the terrarium environment

Locks should feel like they *evolved* around the original seal over centuries of isolation.

---

## Chamber Progression

| # | Biome | Discovery |
|---|---|---|
| 1 | Mossy forest floor | Basic creatures, first clues something is wrong |
| 2 | Underground fungal network | The terrarium has a memory — organisms store information |
| 3 | Flooded glass wall edge | Someone tried to escape before you |
| 4 | The Sealed Core | Why it was locked. Whether to open it. |

---

## Art Direction

### Sprite Size
- **16x16** base sprites (sweet spot for jam scope and grid readability)
- Render at **3x or 4x** scale to fill the screen
- Optional hybrid: **32x32** characters/enemies on **16x16** tiles for more expressiveness

### Palette Strategy
All sprites are drawn in **grayscale/monochrome**. Color is added entirely in engine via **CanvasModulate** — one node that multiplies a single color over the whole scene. Each chamber gets its own color, giving it a strong identity with zero extra sprite work.

| Chamber | CanvasModulate Color | Vibe |
|---|---|---|
| Mossy Floor | Warm green | Overgrown, alive, earthy |
| Fungal Deep | Sickly yellow-green | Bioluminescent, unsettling |
| Flooded Edge | Cold blue | Still, pressured, melancholy |
| Sealed Core | Deep amber/red | Ancient, dangerous, final |

### Outline Style
Since CanvasModulate multiplies over everything, pure white in your sprites becomes the full chamber color and pure black stays black. Lean into this — use **light greys for highlights** and **dark greys for shadows/outlines** and the tinting will do the rest naturally.

---

## Audio Direction
- Ambient hum and glass resonance as base atmosphere
- Sounds should feel muffled/contained — everything heard through glass
- Creature sounds: small, strange, unfamiliar

---

## Godot Implementation Notes

### Where Godot Shines Here
- **TileMap + TileSet** — built for this exact grid-based structure; handles biome tile layers, collision, and custom data cleanly
- **CanvasModulate** — the primary source of all color; swap its color value on chamber transition for an instant biome shift with no extra sprites
- **Signals** — clean turn management; creatures and objects subscribe to a global `TurnManager` that emits `turn_taken`, keeping logic decoupled
- **Resources** — define creatures, items, and lock puzzles as custom Resources for easy data-driven design without a separate format
- **AnimationPlayer** — smooth turn animations (hop, attack, unlock) without breaking the turn-based feel; just await the animation before advancing the turn

### Suggested Scene Structure
```
World
├── TurnManager (Autoload)
├── TileMap (terrain + collision)
├── Entities (Node2D container)
│   ├── Player
│   └── Creature (x N)
├── LockPuzzle (per chamber seal)
└── CanvasModulate (chamber color)
```

### Scope Notes (Jam Feasibility)
- No physics needed — pure tile logic and state machines via GDScript
- Monochrome sprites + CanvasModulate means one sprite set covers all four chambers
- Focus art effort on one strong tile set first, then palette shift for the rest
- Custom Resources for creature/item data means fast iteration without touching scene files
