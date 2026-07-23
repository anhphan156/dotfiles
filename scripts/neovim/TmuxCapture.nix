{
  writeShellApplication,
  tmux,
}:
writeShellApplication {
  name = "TmuxCapture";
  runtimeInputs = [tmux];
  text = ''
    prev=/tmp/vimtmux_prev
    curr=/tmp/vimtmux_curr
    new=/tmp/vimtmux_new

    curr_pane=$(tmux display-message -p '#{pane_id}')
    next_pane=$(tmux list-panes -F '#{pane_id}' | grep -A 1 "$curr_pane" | tail -n 1)
    tmux capture-pane -S - -E - -p -t "$next_pane" > $curr

    if [[ -f "$prev" ]]; then
      diff --unchanged-line-format="" "$prev" "$curr" > "$new"
    else
      cp "$curr" "$new"
    fi

    mv "$curr" "$prev"
  '';
}
