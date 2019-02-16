PROMPT='%{$fg[cyan]%}%3~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %{$reset_color%}'

RPROMPT='%{$fg[yellow]%}$(osascript -e "
tell application \"Rdio\"
    if get running then
        set cTrack to name of current track
        set cAlbum to album of current track
        set cArtist to artist of current track
        set names to cTrack & \" ϟ \" & cAlbum & \" ϟ \" & cArtist
        -- handle \"play something new\" case
        -- rdio returns NaN for \"player position\" otherwise
        if names = \" ϟ  ϟ \" then
            return
        end if

        set tTime to duration of current track
        set cPercent to player position
        set cTime to (cPercent / 100) * tTime
        set tMin to round (tTime / 60) rounding down
        set tSec to round (tTime mod 60) rounding down
        if tSec < 10 then
            set tSec to \"0\" & tSec
        end if
        set cMin to round (cTime / 60) rounding down
        set cSec to round (cTime mod 60) rounding down
        if cSec < 10 then
            set cSec to \"0\" & cSec
        end if
        set timing to \"[\" & cMin & \":\" & cSec & \"/\" & tMin & \":\" & tSec & \"] \"

        return timing & names
    end if
end tell
")'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
