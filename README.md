# IMG 420 — GDExtension Sprite2D Upgrade (FlappySprite)

## Overview
This project upgrades my Assignment 1 “Flappy” game by adding a custom C++ **GDExtension** node, **`FlappySprite`** (extends `Sprite2D`). It provides sprite behaviors not available out-of-the-box and integrates with existing GDScript logic.

## New Node: `FlappySprite` (C++)
**Features**
- **Parametric bobbing** (sinusoidal Y motion in `_process()`).
- **Auto-tilt** based on vertical movement/phase.
- **Runtime controls**: `play()`, `pause()`, `stop()` (no AnimationPlayer).

**Editor parameters**
- `amplitude: float` – bob height  
- `frequency: float` – bob speed  
- `tilt_strength: float` – rotation magnitude

**Signals**
- `bobbing_peak(sprite: Node, pos: Vector2)` – emitted at sine crests.

**Methods (driven by other nodes)**
- `on_game_event(state: String)` – reacts to `GameState` (e.g., `"game_over"` pauses/greys, `"resume"` resumes).

## Scene Integration
- `Bird` (CharacterBody2D) has child **`GDBirdSprite`** (an instance of `FlappySprite`).
- `Bird.gd` connects:
  - `FlappySprite.bobbing_peak → Bird._on_bird_bobbing_peak` (visual cue).
  - `GameState.game_event → FlappySprite.on_game_event` (pause/resume on state).
- Collisions:
  - Pipes tagged via group `"pipe"`; shielded hits delete the whole `PipePair`.
  - **Ground death** via `death_floor_ratio` (screen-relative floor) in `Bird.gd`.

## Rubric Mapping
- **2+ features via Sprite2D extension:** bobbing + tilt ✅  
- **Each feature has an editor parameter:** amplitude/frequency/tilt_strength ✅  
- **Signal from new node triggers existing node:** `bobbing_peak` → `Bird.gd` ✅  
- **Method in new node triggered by existing signal:** `GameState.game_event` → `on_game_event` ✅  
- **(Extra credit)** Animation authored in C++ with `play/pause/stop`, no built-in AnimationPlayer ✅

## Project Structure (submitted)
