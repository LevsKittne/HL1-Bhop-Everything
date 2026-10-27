# HL1-Bhop-Everything — Bunnyhop et déplacement GoldSrc / Half-Life 1

[English / Languages / 多语言 / Языки](README.md) · **Français**

Des instructions pour intégrer le bunnyhop (bhop), les sauts automatiques et l’accélération aérienne à des jeux 3D modifiables avec une IA de programmation. Guides Unity, Unreal Engine et Godot, exemples C++, C# et GDScript, et tests communs.

## Bien démarrer

Téléchargez le dépôt, ouvrez-le dans un assistant capable de lire et modifier les fichiers, puis remplacez <CHEMIN> par le chemin réel du jeu ou du projet.

[Guide pas à pas en anglais](docs/START-HERE.en.md)

```text
Lis AGENTS.md et docs/START-HERE.en.md.
Ajoute classic-bhop au jeu/projet <CHEMIN>, avec saut automatique lorsque la touche
reste enfoncée et un compteur UPS horizontal lisible.
Identifie d’abord le moteur, les unités, le code qui écrit la vitesse et l’autorité du mouvement.
Intègre au contrôleur existant en préservant hauteur de saut, collisions,
vérification de l’espace en position accroupie et commandes. Traduis le guide du moteur en français.
Implémente, compile et teste. Fournis l’installation, le retour à l’état initial et les résultats réels.
Indique les tests non exécutés ; ne t’arrête pas au pseudocode.
```

L’accès au code source, à une API de mods ou à un point d’extension vérifié est nécessaire. Ce n’est pas un patch universel. En multijoueur, simulation serveur et prédiction client doivent partager les mêmes règles.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## Portée de la traduction

Cette introduction et la demande à l’IA sont en français. Un guide pas à pas existe en anglais ; les guides détaillés des moteurs restent principalement en russe. Demandez une traduction conservant formules, unités et exigences de test. Consultez VALIDATION.md pour les vérifications réellement effectuées.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
