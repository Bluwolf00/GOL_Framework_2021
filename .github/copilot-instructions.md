# Copilot Instructions — Commit Messages (GOL_FRAMEWORK_2021)

When generating commit messages, use this exact template:

Title (Example: Updated Gear and Roles)
+ (Added something new)
~ (Changed something existing)
- (Removed something)

Rules:
- Title is a short, human-readable summary of the functional intent (no trailing period).
- Use `+` only for newly introduced functionality/content.
- Use `~` for modifications to existing functionality/content.
- Use `-` for removals/deprecations.
- Include **all functional changes** in the message (anything that changes mission behavior): init flow, modules, Eden attributes, spawn logic, scripts, roles/loadouts, AI/spawn systems, performance-impacting logic.
- Do not add extra sections or alternative bullet styles. Omit unused prefixes if there were no changes of that type.
- Prefer one change per line; include the area when helpful (e.g., `(Modules)`, `(Core)`, `(Eden)`, `(Init)`).

Example:

Refined Mission Startup
+ Added optional callsign assignment module (Modules)
~ Changed init order to avoid duplicate handlers (Core)
- Removed legacy spawn list parsing (spawnList)
