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

## Contrôle d’adoption · Adoption check · Comprobación de adopción

[Français : essayer un cas concret](examples/adoption-check.md) · [English: try a concrete case](examples/adoption-check.md) · [Español: pruebe un caso concreto](examples/adoption-check.md).

## Native selection identity / Identité native / Identidad nativa

EN: The Luau implementation and Studio entry point now enforce the 255-Instance bound instead of truncating the selection. Distinct Instances with the same name and full path retain separate selected IDs; path strings are descriptions, not unique identities. Duplicate IDs block the whole review. The standalone Luau regression runs against the real `Core.lua`, in addition to JavaScript checks. Studio loading, permissions and UI navigation still require host validation.

FR : L’implémentation Luau et l’entrée Studio appliquent désormais la limite de 255 Instances au lieu de tronquer la sélection. Des Instances distinctes de même nom et chemin conservent leurs ID sélectionnés ; les chemins sont descriptifs, pas des identités uniques. Des ID dupliqués bloquent toute la revue. La régression Luau exécute le vrai `Core.lua`, en plus des contrôles JavaScript. Chargement Studio, permissions et navigation restent à vérifier dans l’hôte.

ES: La implementación Luau y la entrada Studio aplican el límite de 255 Instances en lugar de truncar la selección. Instances distintas con el mismo nombre y ruta conservan sus ID seleccionados; las rutas describen, no identifican de forma única. ID duplicados bloquean toda la revisión. La regresión Luau ejecuta el verdadero `Core.lua`, además de controles JavaScript. Carga Studio, permisos y navegación siguen requiriendo validación en el host.


FR : Le validateur Luau refuse `NaN` pour les probabilités, ainsi que les compteurs de tokens absents, négatifs, fractionnaires ou hors des entiers sûrs. Une réponse invalide ne peut plus masquer silencieusement une anomalie en ne sélectionnant aucune issue. La régression exécute le vrai module Core dans Luau 0.739 ; aucun Studio interactif ni modèle réel testé.

EN: The Luau validator rejects `NaN` probabilities and missing, negative, fractional or unsafe-integer token counters. Invalid responses can no longer silently hide a problem by selecting no issue. The regression executes the real Core module in Luau 0.739; no interactive Studio or live model tested.

ES: El validador Luau rechaza probabilidades `NaN` y contadores de tokens ausentes, negativos, fraccionarios o fuera de enteros seguros. Una respuesta inválida ya no oculta silenciosamente problemas al no seleccionar ninguna incidencia. La regresión ejecuta Core real en Luau 0.739; sin Studio interactivo ni modelo real.
