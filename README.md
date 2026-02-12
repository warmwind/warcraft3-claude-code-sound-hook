# Warcraft III Sound Hook for Claude Code

Hear Warcraft III worker voice lines while you code with [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

When you send a prompt, a random race's worker says their **accept** line (*"Yes, milord"*, *"Something need doing?"*, *"I wish only to serve"*, ...). When Claude finishes, that same race's worker announces **work complete** (*"Job's done"*, *"Work complete"*, *"Ready to serve"*, ...).

## Quick Install

```bash
git clone https://github.com/warmwind/warcraft3-claude-code-sound-hook.git
cd warcraft3-claude-code-sound-hook
./install.sh
```

Then add hooks to `~/.claude/settings.json` (the installer prints the exact JSON).

## Manual Install

1. Copy sounds to `~/.claude/wc3sounds/`:

```bash
cp -r sounds/* ~/.claude/wc3sounds/
```

2. Copy scripts to `~/.claude/`:

```bash
cp scripts/wc3_accept.sh ~/.claude/wc3_accept.sh
cp scripts/wc3_complete.sh ~/.claude/wc3_complete.sh
chmod +x ~/.claude/wc3_accept.sh ~/.claude/wc3_complete.sh
```

3. Add hooks to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "type": "command",
        "command": "$HOME/.claude/wc3_accept.sh"
      }
    ],
    "Stop": [
      {
        "type": "command",
        "command": "$HOME/.claude/wc3_complete.sh"
      }
    ]
  }
}
```

If you already have hooks in your settings, merge these entries into your existing `UserPromptSubmit` and `Stop` arrays.

## How It Works

1. **On prompt submit** — `wc3_accept.sh` picks a random race (Human, Orc, Undead, Night Elf), saves the choice to `/tmp/wc3_current_race`, and plays a random "accept command" voice line from that race.
2. **On response complete** — `wc3_complete.sh` reads which race was picked and plays that race's "work complete" voice line, so the accept and complete sounds always match.

## Sound Files

| Race | Accept Lines | Complete Line |
|------|-------------|---------------|
| **Human** (Peasant) | *"Yes, milord"*, *"What is it?"*, *"More work?"*, ... (8 clips) | *"Job's done"* |
| **Orc** (Peon) | *"Yes?"*, *"What you want?"*, *"Something need doing?"*, ... (8 clips) | *"Work complete"* |
| **Undead** (Acolyte) | *"I wish only to serve"*, *"Thy bidding, master?"*, ... (9 clips) | *"Ready to serve"* |
| **Night Elf** (Wisp) | *(mystical wisp sounds)* (6 clips) | *(wisp ready sound)* |

## Customization

**Use only certain races** — edit the `RACES=()` array in both scripts:

```bash
# Only Human and Orc
RACES=("human" "orc")
```

**Add your own sounds** — drop `.wav` or `.mp3` files into the appropriate `~/.claude/wc3sounds/<race>/<accept|complete>/` directory. The scripts pick randomly from whatever files are there.

**Change volume** — edit the `afplay` command in the scripts to add a volume flag:

```bash
afplay -v 0.5 "$SOUND" &   # 50% volume
```

## Requirements

- **macOS** — uses `afplay` for audio playback
- **Claude Code** — requires [hooks support](https://docs.anthropic.com/en/docs/claude-code/hooks)

For Linux, replace `afplay` with `aplay`, `paplay`, or `mpv --no-video` in the scripts.

## Credits

Sound files are from Warcraft III: Reign of Chaos by Blizzard Entertainment. This project is a fan-made tool for personal use and is not affiliated with or endorsed by Blizzard Entertainment.

## License

MIT
