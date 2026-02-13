#!/bin/bash
# WC3 Worker Ask Sound
# Plays a "what do you need?" voice line when Claude asks for user input
# (permission requests, questions, etc.)

SOUNDS_DIR="$HOME/.claude/wc3sounds"
RACE_FILE="/tmp/wc3_current_race"

# Read the race from the accept hook
if [ -f "$RACE_FILE" ]; then
    RACE=$(cat "$RACE_FILE")
else
    RACES=("human" "orc" "undead" "nightelf")
    RACE="${RACES[$((RANDOM % ${#RACES[@]}))]}"
fi

# Pick an ask sound from that race
ASK_DIR="$SOUNDS_DIR/$RACE/ask"
VALID_FILES=()
for f in "$ASK_DIR"/*.mp3 "$ASK_DIR"/*.wav; do
    [ -f "$f" ] && VALID_FILES+=("$f")
done

if [ ${#VALID_FILES[@]} -gt 0 ]; then
    SOUND="${VALID_FILES[$((RANDOM % ${#VALID_FILES[@]}))]}"
    afplay "$SOUND" &
fi

# Ring terminal bell so tmux highlights this window
{ printf '\a' > /dev/tty; } 2>/dev/null || true
