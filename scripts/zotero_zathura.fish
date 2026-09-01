#!/usr/bin/env fish

set ZOTERO_FILES_DIR ~/Zotero/storage

# 1. Grab all matching paths
set full_paths $ZOTERO_FILES_DIR/*/*.pdf

# 2. Extract just the filenames (removes directory prefixes)
set clean_names (path basename $full_paths)

# 3. Pass clean names to fzf and capture the user's selection
set selected_name (printf "%s\n" $clean_names | fzf)

# 4. If a selection was made, match the filename back to its full path
if test -n "$selected_name"
    for path in $full_paths
        if test (path basename $path) = "$selected_name"
            zathura "$path" >/dev/null 2>&1 &; disown
            break
        end
    end
end
