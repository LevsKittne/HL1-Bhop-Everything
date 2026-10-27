# HL1-Bhop-Everything — Bunnyhop y movimiento GoldSrc / Half-Life 1

[English / Languages / 多语言 / Языки](README.md) · **Español**

Guías para integrar bunnyhop (bhop), saltos automáticos y aceleración aérea de GoldSrc en juegos 3D modificables con ayuda de una IA. Incluye instrucciones para Unity, Unreal Engine y Godot, ejemplos en C++, C# y GDScript, y pruebas compartidas.

## Primeros pasos

Descarga el repositorio, ábrelo en un asistente que pueda leer y editar archivos y sustituye <RUTA> por la ruta real de tu juego o proyecto.

[Guía paso a paso en inglés](docs/START-HERE.en.md)

```text
Lee AGENTS.md y docs/START-HERE.en.md.
Añade classic-bhop al juego/proyecto <RUTA>, con salto automático al mantener
la tecla y un medidor UPS horizontal legible.
Identifica el motor, las unidades, quién escribe la velocidad y la autoridad de movimiento.
Integra el cambio en el controlador existente; conserva altura de salto, colisiones,
comprobación de espacio al agacharse y controles. Traduce la guía del motor al español.
Implementa, compila y prueba. Entrega instalación, restauración y los resultados reales;
indica qué pruebas no pudiste ejecutar. No te limites a pseudocódigo.
```

Se necesita código fuente, una API de mods o un punto de extensión verificado. No es un parche universal. El multijugador requiere simulación y predicción compatibles con el servidor.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## Alcance de la traducción

Esta introducción y el mensaje para la IA están en español. Hay una guía paso a paso en inglés; las guías detalladas de motores siguen principalmente en ruso. Pide una traducción que conserve fórmulas, unidades y requisitos de prueba. Consulta VALIDATION.md para conocer lo que se probó.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
