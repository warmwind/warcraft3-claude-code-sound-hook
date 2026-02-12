#!/bin/bash
# WC3 Worker Complete Sound
# Reads the race chosen by the accept hook and plays that race's "complete" voice line

SOUNDS_DIR="$HOME/.claude/wc3sounds"
RACE_FILE="/tmp/wc3_current_race"

# Read the race from the accept hook
if [ -f "$RACE_FILE" ]; then
    RACE=$(cat "$RACE_FILE")
else
    # Fallback: random race
    RACES=("human" "orc" "undead" "nightelf")
    RACE="${RACES[$((RANDOM % ${#RACES[@]}))]}"
fi

# Pick a complete sound from that race
COMPLETE_DIR="$SOUNDS_DIR/$RACE/complete"
VALID_FILES=()
for f in "$COMPLETE_DIR"/*.mp3 "$COMPLETE_DIR"/*.wav; do
    [ -f "$f" ] && VALID_FILES+=("$f")
done

if [ ${#VALID_FILES[@]} -gt 0 ]; then
    SOUND="${VALID_FILES[$((RANDOM % ${#VALID_FILES[@]}))]}"
    afplay "$SOUND" &
fi
