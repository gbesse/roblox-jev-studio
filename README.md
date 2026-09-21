# Roblox Jev Studio

A dockable Roblox Studio plugin that reviews metadata for the Instances you explicitly select, then lets you jump back to the exact cited Instances. Jev answers declared finite questions and selects existing Instance IDs; it never edits the DataModel or writes free-form critique.

## Build and install

The repository follows a Rojo layout:

```bash
rojo build default.project.json -o RobloxJevStudio.rbxm
```

Import the model into Studio and save the root script as a local plugin, or sync into `PluginDebugService`. The first request may trigger Roblox's per-domain network permission prompt. The API key lives only in the dock widget's `TextBox`; the plugin never calls `SetSetting`.

The default pack reviews naming, hierarchy ambiguity, and unclear responsibility using only Instance name, class, and full path. It is not a security scanner, runtime profiler, or substitute for playtesting.

## Validate

```bash
npm test
npm run check
npm run demo
```

The checks and demo are offline. Every source file is syntax-compiled with Luau 0.739 in CI. Roblox Studio was not installed in the build environment, so Rojo model generation, plugin loading, and the permission prompt remain host-specific checks.

MIT — see [LICENSE](LICENSE).
