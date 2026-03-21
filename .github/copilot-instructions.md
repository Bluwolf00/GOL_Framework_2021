# Copilot Instructions — Commit Messages (GOL_FRAMEWORK_2021)
When generating commit messages, use this exact template:

Title (Example: Updated Gear and Roles)
+ Added something new
~ Changed something existing
- Removed something

Rules:
- Title is a short, human-readable summary of the functional intent (no trailing period).
- Use `+` only for newly introduced functionality/content.
- Use `~` for modifications to existing functionality/content.
- Use `-` for removals/deprecations.
- Include **all functional changes** in the message (anything that changes gameplay/behavior):
    scripts, configs, Eden settings, modules,
    AI behavior, loadouts/roles, UI behavior,
    networking/state, performance-impacting logic.
- Do not add extra sections or alternative bullet styles. Omit unused prefixes if there were no changes of that type.
- Prefer one change per line; include the subsystem in brackets when helpful (e.g., `[CfgFunctions]`, `[CfgVehicles]`, `[AI System]`).

Example:

Updated Gear and Roles
+ Added automatic medic loadout fallback [Medical]
~ Adjusted squad lead role radios and magazines [CfgWeapons]
- Removed legacy ACE incompat workaround [Core]