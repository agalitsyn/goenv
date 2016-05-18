Шаблон для рабочего окружения проектов на golang

# Как начать работать?

- Вы скачивайте этот репозиторий локально, можно через `git clone`, потому что `src` игнорируются.
- Настраиваете окружение по инструкции ниже.
- Пробуете пример.
- Пишете свое решение.

# Настройка окружения

## Golang

```sh
$ sudo apt-get install golang
```

Если уже установлен, проверяем версию.

```sh
$ go version
go version go1.6.1 linux/amd64
```

Рекомендуется использовать самую последнюю версию, которую можно найти на [golang.org][godl].

Если по какой-то причине вы не можете установить последнюю версию, например ее нет в репозиториях, или
вам нужно одновременно иметь несколько версий go, попробуйте утилиту [gimme][gimme].

### Workspace

Этот репозиторий является реализацией workspace согласно [документу][gocode].

#### Переменные окружения

Посмотрите файл `scripts/init-go-path.sh`.

Достаточно выполнить `make init-go-path`, либо можете настрить все вручную по [документу][gocode].

Проверяем `GOPATH`:

```sh
$ go env
```

*Важно*: `GOPATH` дает разработчикам гибкость и они сами решают, сколько таких окружений у них есть.
Но я лично использую одно окружение на один проект, как это принято в python, nodejs, php проектах.
Так проще работать, следить  за зависимостями и не иметь проблем со сборкой и вендорингом.

### Файловое дерево

Должно получиться следующее:

```
├── bin
├── pkg
├── src
│   ├── github.com
│   │   └── ...

```

### Смотрим пример

```sh
$ make get-example
$ make install-example
$ make test-example
```

### Golang dev tools

```sh
$ make install-go-tools
```

### Делаем go get с gitlab.2gis.ru

Утилита `go get` по-умолчанию использует https. Чтобы это исправить - выполните:

```sh
$ git config --global url."git@gitlab.2gis.ru:".insteadOf "https://gitlab.2gis.ru/"
```

### Качаем boilerplate для проекта в Deis

```sh
$ go get gitlab.2gis.ru/continuous-delivery/go-example

```
## Настройка редактора

Для idea есть [go plugin][goplug], будет работать на любых IDE от JetBrains.

Подробную инструкцию по настройке можете найти
[здесь](https://rootpd.com/2016/02/04/setting-up-intellij-idea-for-your-first-golang-project/).

## Другие рекомендации

Много других материалов по go можно найти в [confluence][golang-must-read].

[gocode]: https://golang.org/doc/code.html
[gimme]: https://github.com/travis-ci/gimme
[godl]: https://golang.org/dl/
[goplug]: https://github.com/go-lang-plugin-org/go-lang-idea-plugin

[golang-must-read]: https://github.com/heroku/go-getting-started

