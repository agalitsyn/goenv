Шаблон для рабочего окружения проектов на golang

# Как начать работать?

- Вы скачивайте этот репозиторий локально. Лучше скачать архивом, так как вам не нужна его git составляющая.
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

## Workspace

Настраиваем согласно [документу][gocode].

### Переменные окружения

Посмотрите файл `scripts/init-go-path.sh`.

Достаточно выполнить `make init-go-path`, либо можете настрить все вручную по [документу][gocode].

Проверяем `GOPATH`:

```sh
$ go env
```

## Файловое дерево

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
$ go get TODO
```

# Общие соглашения

## Настройки репозитория

Традиционно репозитории заводятся на [gitlab][gitlab].

Настраивается [здесь][this-repo]

### Общее

* `Project name` - пишется через дефис. Это имя будет фигурировать в URLе git репозитория.
  Если ваш репозиторий будет использоваться в качестве библиотеки, то утилиты, которые будут выкачивать ваш репозиторий, например `go get`,
  будут использовать его в качестве имени по-умолчанию.
* `Project description` - в интерфейсе помечен как не обязательный, но лучше описать, чтобы другие люди могли сразу
  понять что в репозитории, пролистывая общий список.
* `Default Branch` - `master` по-умолчанию, вообще может быть любая ветка, в которой код можно считать стабильным.
* `Visibility Level` - `internal`. Делать `private` не совсем честно по отношению к коллегам, код должен быть доступен
  внутри компании. Если вам нужно поместить приватные данные, например ssh ключи, зашифруйте файлы с помощью [git-crypt][git-crypt].
  Необходимость делать видимость `public` вообще не имеет смысла, так как gitlab закрыт внутри корпоративной сети. Если
  у вас проблемы с доступом при клонировании репозитория - воспользуйтесь [deploy keys][deploy-keys].
* `Tags` - по желанию, но лучше заполнить.

### Возможности

`Merge Requests` и `Builds` и обязательно, остальное выключить, если вам не нужно.

[Пользователи][users]:
Не стоит делать всех участников `owner` и `master`, их должно быть 2-3 на проект. Достаточно прав `developer`.


## Ведение проекта

- Держим ветку master стабильной. Код должен собираться, все тесты проходить без ошибок.
- Каждую задачу выполняем в отдельной ветке, называем в формате `<JIRA-issue-id>-<short-description>`, например
 `PRJ-16-feature-create-database-scheme`.
- В commit messages пишем осознанные сообщения в формате `[<JIRA-issue-id> What was done]`. Не нужно писать small
  changes или fixup, сообщение должно отвечать на вопрос "что было сделано?".
- В ветку master код добавляется только после merge request. Запретить делать комиты в master можно на странице
  [protected-branches][protected-branches], это делается сочетанием ролей `developer` и выключенной опции `developers
  can push`.
- Желательно включить на странице [сервисов][service] сервисы `email on push` или `slack`, чтобы всегда быть в курсе
  новых изменений.

## Code review

### Цели

- Уменьшить bus-factor (увеличить долю владения кодом командой).
- Улучшить качество кода.
- Уменьшить вероятность внесения ошибок в master.
- Совместно найти лучшее решение.

### Когда создавать review?

Кратко - всегда.

Долго - для ревью подходит любой код. Однако, review *обязательно* должно проводиться для критических мест в приложении
(например: механизмы аутентификации, авторизации, передачи и обработки важной информации — обработка денежных транзакций и пр.).
Также для review подходят и юнит тесты, так как юнит тесты — это тот же самый код, который подвержен ошибкам, его нужно
инспектировать также тщательно как и весь остальной код, потому что, неправильный тест может стоить очень дорого.

Мотивация создания review:
- Произошли изменения, которые нужно знать команде.
- Проведено объемное изменение кода.
- Есть сомнения, что выбрано верное архитектурное решение.
- Есть вероятность наличия ошибок.
- Хорошо подходит для обучения «новичков», быстро набирается навык, происходит выравнивание опыта, обмен знаниями

### Кого выбрать в ревьюверы?

В качестве "главного" ревьювера стоит выбирать человека, максимально приближенного к вашей задаче по тематике (как в google — code owner).
Ревьювером может быть несколько. Для критичных мест *обязатально* должно быть несколько ревьюверов.

### Когда review считается успешным?

Review считается успешным, когда все замечания исправлены или согласованы, прошел CI, поставили "большой палец" и смерджили в master.

### На что в review нужно обращать внимание?

Review - процесс взаимодействия человека с человеком. Нужно концентрироваться на:
- Проблематике задачи. Часто в ходе code review код становится не нужен.
- Архитектуре решения.
- Вписывается ли решение в программный дизайн проекта.
- Соблюдается ли принятый в проекте прием/паттерн.

Не нужно концентрироваться на вещах, которые могут проверить роботы в CI, например codestyle.

### Merge requests

Настраивается [тут][merge-requests].

- `Title` - должно быть понятным другим членам команды
- `Description` - обязательно нужно вставить ссылку на задачу в Jira, чтобы человек мог прочитать какую задачу вы
  решаете этим кодом.


Ваш merge request никто не будет смотреть, если:
- Вы никого не назначили в ревьюверы
- Сборка завершилась с ошибкой
- Есть конфликты c master. Нужно их разрешить.
- У вас очень много коммитов. Лишние комиты нужно схлопнуть используя `git rebase --interactive master`. В итоге у вас
  должен получиться либо один комит, либо несколько с конкретной тематикой.
- У вас очень много изменений. Такое ревью смотреть не удобно, разделите его на несколько мелких.
- У вас больше 1 задачи в 1 ревью.

### Continuous integration

CI - процесс получения обратной связи о коде. Этот процесс весьма многогранен и не будет здесь рассмотрен в подробностях.

В контексте code review мы будем говорить о быстрой обратной связи. Продолжительность всего процесса
не должна быть дольше нескольких минут, если CI идет больше 5 - 10м, значит что-то не так.
Обязательно для любых репозиториев с кодом.

#### Этап 1 - статические анализаторы кода

У каждого языка есть linters, у python - `flake8`, y javascript - `eslint`, у go - `golint` и `govet`.
Для ansible можно настроить `ansible-lint` и `ansible-playbook --check`.

Некоторый команды эти вещи выносят в git precommit hook, но человек может их просто не настроить, гонять на сервере -
надежно.

#### Этап 2 - Автотесты

Unit и функциональные тесты вашего приложения. Для их прогона не нужна backing сервисы, должно хватать кода
приложения.

#### Этап 3 - Сборка

Это может быть любой артефакт, например сборка архива приложения, сборка debian пакета или сборка Docker image.

#### Этапы, которые могут быть отдельно

- Smoke тесты, или BVT (build verification test), набор P0 тестов на главный бизнес-функционал приложения. Обычно на
  этом этапе уже нужен собранное приложение, котороей развернуто на какой-то инфраструктуре, для end-to-end тестов. Если
  они прогоняются за приемлимое время - лучше програть сразу.
- Регрессионные тесты.

## Литература

- [https://dzone.com/articles/how-google-does-code-review](https://dzone.com/articles/how-google-does-code-review)


[gitlab]: https://gitlab.2gis.ru
[this-repo]: https://gitlab.2gis.ru/io/platform/edit
[deploy-keys]: https://gitlab.2gis.ru/io/platform/deploy_keys
[services]: https://gitlab.2gis.ru/io/platform/services
[protected-branches]: https://gitlab.2gis.ru/io/platform/protected_branches
[merge-requests]: https://gitlab.2gis.ru/io/platform/merge_requests
[users]: https://gitlab.2gis.ru/io/platform/project_members
[git-crypt]: https://www.agwa.name/projects/git-crypt/

[gocode]: https://golang.org/doc/code.html
[gimme]: https://github.com/travis-ci/gimme
[godl]: https://golang.org/dl/
