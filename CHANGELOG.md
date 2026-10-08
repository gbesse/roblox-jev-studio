# Changelog

## Unreleased

- Reject selections above 255 Instances and duplicate IDs instead of silently dropping or conflating objects. / Refuser plus de 255 Instances et les identifiants en double plutôt que d’omettre ou confondre des objets. / Rechazar más de 255 Instances e identificadores duplicados en vez de omitir o confundir objetos.

- Run the Instance identity guard in CI, verify the pinned Luau compiler checksum, and ignore local environment-file variants.

## 0.1.1

- Use the current asynchronous dock-widget API, reject regressions to the deprecated synchronous API, and add an exact-Instance identity example.

## 0.1.0

- Add strict Luau Studio plugin, dock widget, typed two-pass review, exact-Instance focus, memory-only key, response guards, and offline contract tests.
