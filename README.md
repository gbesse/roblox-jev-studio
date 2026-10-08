# Roblox Jev Studio

A dockable Roblox Studio plugin that reviews metadata for the Instances you explicitly select, then lets you jump back to the exact cited Instances. Jev answers declared finite questions and selects existing Instance IDs; it never edits the DataModel or writes free-form critique.

## Build and install

The repository follows a Rojo layout:

```bash
rojo build default.project.json -o RobloxJevStudio.rbxm
```

Import the model into Studio and save the root script as a local plugin, or sync into `PluginDebugService`. The first request may trigger Roblox's per-domain network permission prompt. The API key lives only in the dock widget's `TextBox`; the plugin never calls `SetSetting`.

The default pack reviews naming, hierarchy ambiguity, and unclear responsibility using only Instance name, class, and full path. It is not a security scanner, runtime profiler, or substitute for playtesting.

## Try the Instance identity guard offline

`npm run demo:guard` builds finite choices from two synthetic selected Instances and rejects a response that cites an Instance outside the selection. No Roblox Studio session or API key is needed. Studio loading and the permission prompt remain host checks.

## Validate

```bash
npm test
npm run check
npm run demo
```

The checks and demo are offline. Every source file is syntax-compiled with Luau 0.739 in CI. Roblox Studio was not installed in the build environment, so Rojo model generation, plugin loading, and the permission prompt remain host-specific checks.

MIT — see [LICENSE](LICENSE).

## October 2026 improvement · Amélioration d’octobre 2026 · Mejora de octubre de 2026

Selection now rejects more than 255 Instances and duplicate IDs instead of silently dropping or conflating objects. This contract check does not validate Roblox Studio behavior.

La sélection refuse désormais plus de 255 Instances et les identifiants en double, au lieu d’omettre ou confondre des objets. Ce contrôle ne valide pas le comportement dans Roblox Studio.

La selección ahora rechaza más de 255 Instances e identificadores duplicados en vez de omitir o confundir objetos. Esta prueba no valida el comportamiento en Roblox Studio.
