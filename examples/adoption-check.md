# roblox-jev-studio — contrôle d’adoption · adoption check · comprobación de adopción

## Français

Point de départ local, après la préparation indiquée dans le README :

```sh
npm run demo:guard
```

Deux Instances peuvent porter le même nom. La réponse doit cibler un ID de la sélection et rejeter un ID inventé ; vérifiez ensuite la navigation réelle dans Studio.

## English

Local starting point, after the setup described in the README:

```sh
npm run demo:guard
```

Two Instances can share a name. The response must point to an ID from the selection and reject an invented ID; then verify actual navigation in Studio.

## Español

Punto de partida local, después de la preparación descrita en el README:

```sh
npm run demo:guard
```

Dos Instances pueden compartir un nombre. La respuesta debe apuntar a un ID de la selección y rechazar uno inventado; compruebe después la navegación real en Studio.
## Variante synthétique · Synthetic variation · Variante sintética

```text
selected_ids=["instance-1","instance-2"]; returned_id="instance-3"
```

FR : adaptez une copie de la fixture locale à cette situation, puis vérifiez le comportement décrit ci-dessus. Les valeurs sont illustratives, pas des résultats Jev mesurés.

EN: adapt a copy of the local fixture to this situation, then check the behavior described above. Values are illustrative, not measured Jev output.

ES: adapte una copia de la fixture local a esta situación y compruebe el comportamiento descrito arriba. Los valores son ilustrativos, no resultados Jev medidos.

## Second cas · Second case · Segundo caso

```text
selected_count=256; selection_limit=255
```

**FR :** Une sélection au-delà de la limite déclarée doit être refusée avant un appel réseau. Vérifiez ensuite le comportement réel de la sélection dans Studio.

**EN:** A selection beyond the declared limit must be rejected before a network call. Then confirm actual selection behavior in Studio.

**ES:** Una selección por encima del límite declarado debe rechazarse antes de una llamada de red. Confirme después el comportamiento real en Studio.
