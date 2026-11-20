# Sleep mode: keep the system awake

Read this in sleep mode, before the start-up questions. Stop the computer from sleeping while the run is active. Start this before the first agent, in the background.

- macOS: `caffeinate -dimsu -t 43200 &`. Keep the process ID.
- Linux: `systemd-inhibit --what=idle:sleep --why="planchunk run" sleep 43200 &`. If it is missing, use another tool the system has (for example `caffeine`).
- Windows: a PowerShell loop that calls `SetThreadExecutionState`, or `powercfg /requestsoverride`.
- If no tool works, tell the user in the start-up questions, so they can change their power settings before they leave.

Rules:
- The time limit (12 hours here) is a safety stop. Change it if the plan is longer.
- Stop the process when the run ends, fails, or the user says stop. Check that it is gone.
- Tell the user that a closed laptop lid can still force sleep. Ask them to keep the lid open and the power plugged in.
- Note the tool and process ID in the run file.
