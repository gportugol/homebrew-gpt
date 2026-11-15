# Tap do G-Portugol para o Homebrew

Fórmula do [GPT](https://github.com/gportugol/gpt), o compilador,
interpretador e tradutor para C da linguagem G-Portugol, para macOS e Linux.

## Instalação

Ainda não há um release do GPT com o parser do ANTLR 4 e o suporte a macOS,
então por enquanto a fórmula compila o `master`:

```shell
brew install --HEAD gportugol/gpt/gpt
```

Se o Homebrew pedir confiança no tap, antes da instalação:

```shell
brew trust --tap gportugol/gpt
```

Para atualizar para o `master` mais recente:

```shell
brew upgrade --fetch-HEAD gpt
```

O que o `gpt` faz em cada sistema está no
[README do GPT](https://github.com/gportugol/gpt#readme) e no
[HACKING.md](https://github.com/gportugol/gpt/blob/master/HACKING.md).

## Documentação do Homebrew

`brew help`, `man brew` ou a [documentação do Homebrew](https://docs.brew.sh).
