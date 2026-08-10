# Async git status for the zsh prompt.
#
# prompt.sh builds the prompt for BOTH bash and zsh and calls __git_ps1
# synchronously. That is fine for bash, but in zsh a slow repo blocks the
# prompt from appearing. This file is zsh-only: it computes the git status in
# a background subshell (via process substitution) and redraws the prompt when
# the result is ready.
#
# ZSH ONLY: relies on zle -F / sysread / PROMPT_SUBST, none of which exist in
# bash. bash keeps the synchronous __git_ps1 in PROMPT_COMMAND. Shell
# detection uses IN_ZSH (set in .bashrc), not ZSH_VERSION, which a bash
# spawned from zsh can inherit.

# Bail out immediately if this file is ever sourced outside zsh.
[ "$IN_ZSH" = 1 ] || return 0

# PROMPT_SUBST is required so the literal ${_async_git_result} baked into
# PROMPT is re-expanded whenever the prompt is drawn (including the redraw
# triggered by zle reset-prompt below).
setopt PROMPT_SUBST

# sysread (from zsh/system) is used to drain the worker pipe without blocking.
zmodload zsh/system 2>/dev/null

typeset -g _async_git_result=""
typeset -g _async_git_fd=""

# Cancel any in-flight computation and close its pipe fd.
_async_git_stop() {
    if [[ -n "$_async_git_fd" ]]; then
        zle -F "$_async_git_fd" 2>/dev/null
        # Closing the pipe fd clobbers the main shell's stderr (zsh issue #35,
        # the same bug zsh-async works around). Save fd 2, close the pipe fd,
        # then restore fd 2.
        exec {_async_git_errfd}>&2
        exec {_async_git_fd}>&- 2>/dev/null
        exec 2>&$_async_git_errfd
        exec {_async_git_errfd}>&-
        _async_git_fd=""
    fi
}

# Called by zle whenever the worker pipe is readable (data or EOF).
# Accumulate output; on EOF the worker is done, so finalize and redraw.
# The fd is deliberately NOT closed here (closing it clobbers stderr);
# _async_git_stop closes it on the next prompt, with the save/restore above.
_async_git_callback() {
    local fd=$1
    local chunk=""
    sysread -i "$fd" chunk
    local rc=$?
    if (( rc == 0 )); then
        # More data available; keep the fd registered for the next callback.
        _async_git_result+="$chunk"
        return
    fi
    # rc == 1: EOF -- the worker has exited, result is complete.
    zle -F "$fd" 2>/dev/null
    zle reset-prompt 2>/dev/null
}

# Kick off the async git computation for the current directory.
_async_git_start() {
    _async_git_stop
    _async_git_result=""

    # Run __git_ps1 in a subshell; its stdout is a pipe we watch with zle -F.
    # EOF on the pipe means the computation finished. The subshell inherits
    # the current directory, so it computes the status for the prompt that was
    # just drawn. An old worker that is still running dies on SIGPIPE when we
    # close the previous fd in _async_git_stop.
    exec {_async_git_fd}< <(
        builtin cd -q "$PWD" 2>/dev/null || exit 1
        __git_ps1 2>/dev/null
    )
    zle -F "$_async_git_fd" _async_git_callback
}
