# Tmux D-Day Plugin

Enable displaying D-Day remains, percentage and icon in tmux statusbar.

Before D-Day:<br/>
`D-72(88%)`

The day:<br/>
`D-Day(100%)`

After D-Day:<br/>
`D+4(100%)`

This is done by introducing 3 new format strings that can be added to
`status-left` or `status-right` option:
- `#{d_day_icon}` - will display a D-Day status icon
- `#{d_day_percentage}` - will show D-Day percentage
- `#{d_day_remain}` - will show remaining days until D-Day

### Usage

Above all, you need to set `@d_day_start_date`(optionally) and `@d_day_end_date` to `.tmux.conf`

```tmux
# To calculate the percentage (optional, if you needed)
set -g @d_day_start_date '2014-07-07'
# Set your D-Day
set -g @d_day_end_date '2016-04-06'
```

Add `#{d_day_icon}`, `#{d_day_percentage}` or `#{d_day_remain}` format
strings to existing `status-left` or `status-right` tmux option. Example:

```tmux
# in .tmux.conf
set -g status-right '#{d_day_icon} #{d_day_remain}(#{d_day_percentage}) | %a %h-%d %H:%M '
```

Don't forget to reload TMUX environment (`$ tmux source-file ~/.tmux.conf`)
after you do this.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)


Add plugin to the list of TPM plugins in `.tmux.conf`:

```tmux
set -g @plugin 'posquit0/tmux-d-day'
```

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-left` or `status-right`, they should now be visible.

### Manual Installation

Clone the repo:

```bash
$ git clone https://github.com/posquit0/tmux-d-day ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/clone/path/d_day.tmux
```

Reload TMUX environment:

```tmux
# type this in terminal
$ tmux source-file ~/.tmux.conf
```

If format strings are added to `status-left` or `status-right`, they should now be visible.

### Changing icons

### Contributors

- [@posquit0](https://github.com/posquit0)

### Contact

If you have any questions, feel free to join me at [`#posquit0` on Freenode](irc://irc.freenode.net/posquit0) and ask away. Click [here](https://kiwiirc.com/client/irc.freenode.net/posquit0) to connect.

Good luck!

### License

[MIT](LICENSE.md)
