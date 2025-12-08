elephant service enable
systemctl --user daemon-reload
systemctl --user start elephant.service
systemctl --user enable elephant.service
systemctl --user status elephant.service
