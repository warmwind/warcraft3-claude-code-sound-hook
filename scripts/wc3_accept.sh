#!/bin/bash
# WC3 Worker Accept Command Sound
# Randomly picks a race and plays one of their "accept" voice lines
# Saves the chosen race to a temp file so the complete hook can use the same race

SOUNDS_DIR="$HOME/.claude/wc3sounds"
RACE_FILE="/tmp/wc3_current_race"

# Pick a random race
RACES=("human" "orc" "undead" "nightelf")
RACE="${RACES[$((RANDOM % ${#RACES[@]}))]}"

# Save chosen race for the complete hook
echo "$RACE" > "$RACE_FILE"

# Pick a random accept sound from that race
ACCEPT_DIR="$SOUNDS_DIR/$RACE/accept"
VALID_FILES=()
for f in "$ACCEPT_DIR"/*.mp3 "$ACCEPT_DIR"/*.wav; do
    [ -f "$f" ] && VALID_FILES+=("$f")
done

if [ ${#VALID_FILES[@]} -gt 0 ]; then
    SOUND="${VALID_FILES[$((RANDOM % ${#VALID_FILES[@]}))]}"
    afplay "$SOUND" &
fi
