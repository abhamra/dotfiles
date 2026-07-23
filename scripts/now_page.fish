#!/usr/bin/env fish
#
# update_now.fish
#
# Archives the current entry in now.md into now-then.md (newest entry
# first, right after the ratfactor intro block), then resets now.md
# with today's date and an empty body, and opens nvim so you can
# write the new entry.

# ---- CONFIG: adjust this to your site's content directory ----
set SITE_ROOT ~/personal/personalsite
set NOW_FILE $SITE_ROOT/content/now.md
set NOW_THEN_FILE $SITE_ROOT/content/now-then.md
# ----------------------------------------------------------------

if not test -f $NOW_FILE
    echo "Error: $NOW_FILE not found. Edit SITE_ROOT in this script."
    exit 1
end
if not test -f $NOW_THEN_FILE
    echo "Error: $NOW_THEN_FILE not found. Edit SITE_ROOT in this script."
    exit 1
end

# --- Find the two '---' body separators in now.md (frontmatter uses +++, so these are unambiguous) ---
set sep_lines (grep -n '^---$' $NOW_FILE | cut -d: -f1)

if test (count $sep_lines) -lt 2
    echo "Error: couldn't find two '---' separators in now.md. Aborting."
    exit 1
end

set sep1 $sep_lines[1]
set sep2 $sep_lines[2]

# --- Pull the old date out of the "*Updated ...*" line. Search for it by
#     pattern (anywhere above sep1) rather than assuming it's exactly one
#     line above the separator, since blank lines / formatting can shift it. ---
set updated_line_num (sed -n "1,$sep1 p" $NOW_FILE | grep -n '^\*Updated ' | tail -n1 | cut -d: -f1)

if test -z "$updated_line_num"
    echo "Error: couldn't find a line starting with '*Updated ' before the first '---' separator (line $sep1)."
    echo "--- Lines 1 through $sep1 of $NOW_FILE, for reference: ---"
    sed -n "1,$sep1 p" $NOW_FILE | cat -A | head -30
    exit 1
end

set updated_line (sed -n "$updated_line_num p" $NOW_FILE)
set old_date (echo $updated_line | sed -E 's/^\*Updated ([^*]+)\*.*$/\1/')

if test -z "$old_date"; or test "$old_date" = "$updated_line"
    echo "Error: found the line but couldn't parse a date out of it:"
    echo "  >> $updated_line"
    exit 1
end

# --- Grab the body text (everything strictly between sep1 and sep2) ---
set body_start (math $sep1 + 1)
set body_end (math $sep2 - 1)
set body_text (sed -n "$body_start,$body_end p" $NOW_FILE)

if test -z "$body_text"
    echo "Warning: current now.md body looks empty — nothing to archive?"
end

# --- Everything after sep2 (the footer / Sivers credit block) — kept as-is in now.md ---
set footer_start (math $sep2 + 1)
set footer_text (sed -n "$footer_start,\$p" $NOW_FILE)

# --- Everything up through the frontmatter's closing +++ in now.md — kept as-is ---
set frontmatter_end (grep -n '^+++$' $NOW_FILE | sed -n '2p' | cut -d: -f1)
set frontmatter_text (sed -n "1,$frontmatter_end p" $NOW_FILE)

# ================= 1. Archive into now-then.md =================

set nowthen_seps (grep -n '^---$' $NOW_THEN_FILE | cut -d: -f1)
if test (count $nowthen_seps) -lt 2
    echo "Error: couldn't find the intro '---' block in now-then.md. Aborting."
    exit 1
end
set insert_after $nowthen_seps[2]

set tmp_nowthen (mktemp)

# lines 1..insert_after unchanged
sed -n "1,$insert_after p" $NOW_THEN_FILE > $tmp_nowthen

# new archived entry
echo "" >> $tmp_nowthen
echo "### *$old_date*" >> $tmp_nowthen
for line in $body_text
    echo $line >> $tmp_nowthen
end

# rest of the old now-then.md (previous entries), unchanged
set rest_start (math $insert_after + 1)
sed -n "$rest_start,\$p" $NOW_THEN_FILE >> $tmp_nowthen

mv $tmp_nowthen $NOW_THEN_FILE
echo "Archived $old_date entry into now-then.md"

# ================= 2. Reset now.md =================

set today (date "+%B %-d, %Y")

set tmp_now (mktemp)

for line in $frontmatter_text
    echo $line >> $tmp_now
end
echo "*Updated $today*, old updates at [/now-then](/now-then)." >> $tmp_now
echo "" >> $tmp_now
echo "---" >> $tmp_now
echo "" >> $tmp_now
echo "" >> $tmp_now
echo "" >> $tmp_now
echo "---" >> $tmp_now
for line in $footer_text
    echo $line >> $tmp_now
end

mv $tmp_now $NOW_FILE
echo "Reset now.md with today's date ($today)"

# ================= 3. Open nvim at the blank line for the new entry =================
#
# now.md now looks like:
#   1..frontmatter_end        frontmatter (+++ ... +++)
#   frontmatter_end + 1       *Updated <date>* line
#   frontmatter_end + 2       (blank)
#   frontmatter_end + 3       ---              <- first separator
#   frontmatter_end + 4       (blank)
#   frontmatter_end + 5       (blank)          <- cursor lands here
#   frontmatter_end + 6       (blank)
#   frontmatter_end + 7       ---
#   ...                       footer

set new_blank_line (math $frontmatter_end + 5)
nvim +$new_blank_line $NOW_FILE
