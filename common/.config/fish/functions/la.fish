function la --wraps='eza' --description 'alias la eza'
    eza (string split -n " " -- $EZA_STANDARD_OPTIONS) (string split -n " " -- $EZA_LA_OPTIONS) (string split -n " " -- $EZA_L_OPTIONS) $argv
end
