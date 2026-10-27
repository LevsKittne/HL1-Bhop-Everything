# HL1-Bhop-Everything — Bunnyhop e movimentação GoldSrc / Half-Life 1

[English / Languages / 多语言 / Языки](README.md) · **Português (Brasil)**

Instruções para adicionar bunnyhop (bhop), saltos automáticos e aceleração no ar a jogos 3D modificáveis com ajuda de uma IA. Inclui guias para Unity, Unreal Engine e Godot, exemplos em C++, C# e GDScript e testes compartilhados.

## Como começar

Baixe o repositório, abra a pasta em um assistente que possa ler e editar arquivos e substitua <CAMINHO> pelo caminho real do jogo ou projeto.

[Guia passo a passo em inglês](docs/START-HERE.en.md)

```text
Leia AGENTS.md e docs/START-HERE.en.md.
Adicione classic-bhop ao jogo/projeto <CAMINHO>, com salto automático ao segurar
a tecla e um medidor horizontal de UPS legível.
Identifique o motor, as unidades, quem escreve a velocidade e a autoridade do movimento.
Integre ao controlador existente, preservando altura normal do salto, colisões,
verificação de espaço ao agachar e controles. Traduza o guia do motor para português.
Implemente, compile e teste. Entregue instalação, restauração e resultados reais.
Informe quais testes não foram executados; não entregue apenas pseudocódigo.
```

É preciso ter acesso ao código-fonte, a uma API de mods ou a um ponto de extensão verificado. Não é um patch universal. No multijogador, a simulação e a previsão precisam corresponder às regras do servidor.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## Escopo da tradução

Esta introdução e o pedido para a IA estão em português. Há um guia passo a passo em inglês; os guias detalhados dos motores ainda estão principalmente em russo. Peça uma tradução preservando fórmulas, unidades e testes. Consulte VALIDATION.md para o estado real da validação.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
