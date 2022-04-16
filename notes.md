# Heroku

## How it works

> Application = source code + dependency description

- dependency in form of `requirements.txt` for python

### How to define entrypoint

Heroku executes

- either default stuff like Djangos `python <app>/manage.py runserver`
- OR according to [Procfile](https://devcenter.heroku.com/articles/procfile)

An example procfile

- each line describes a [process type](https://devcenter.heroku.com/articles/process-model) and a command
- only `web` process type receives HTTP traffic (automatically distributed across dynos by Heroku)

```
web: java -jar lib/foobar.jar $PORT 
queue: java -jar lib/queue-processor.jar
```

### How to deploy

- git (primary form)
  - use a new remote usually named `heroku`
- [github integration](https://devcenter.heroku.com/articles/github-integration)
- [Heroku API](https://devcenter.heroku.com/articles/build-and-release-using-the-api)
- ... ?

### How application is built

Typically dependencies are retrieved and installed language specifically

> Slug = TAR-files = source code + dependencies + built output (e.g. compiled code / build artifacts) 

Every time you deploy, a new slug is created and a *release* is generated.

> Release = slugs + config vars + add-ons in the form of an append-only ledger

You can see releases and rollback via `heroku release` or `heroku releases:rollback v102`

### How applications are run

> Dyno = isolated unix containers providing environment for application

- Heroku executes application by running command
  - on a dyno
  - plus preloaded slug
  - plus config variables
- You can start multiple dynos in parallel using e.g. `heroku ps:scale web=3 queue=2`
- All dynos...
  - have access to the *same* set of config vars at runtime. 
  - do not share file state


> Dyno manager = responsible for managing dynos across all applications

*One-off* dynos can be run with input/output attached to terminal, e.g. `heroku run bash`

### How add-ons work

- add-ons are treated as attached resources
- can be used as a shared state (e.g. for a queue) between your dynos

## How to make Python Apps

see https://devcenter.heroku.com/categories/python-support

- recognized as python app using one of the following files
  - `requirements.txt`
  - `setup.py`
  - `Pipfile`
- use the python-3.9.10 runtime by default, but can be customized via  `echo "python-3.10.2" > runtime.txt` 
- Postgres database
  - is automatically provisioned for Django applications a hobby-dev 
  - can be manually provisioned else

### Hello world 

- http://octomaton.blogspot.com/2014/07/hello-world-on-heroku-with-python.html
- https://github.com/leah/hello-flask-heroku

### App.json

```json
{
  "name": "hello-flask-heroku",
  "description": "A hello world app in Flask for deploying to Heroku.",
  "repository": "https://github.com/leah/hello-flask-heroku",
  "keywords": ["flask", "heroku"]
}
```

An `app.json` ...

- is optional
- is necessary for the [Deploy to Heroku](https://devcenter.heroku.com/articles/heroku-button) button

### Using docker containers

https://devcenter.heroku.com/categories/deploying-with-docker

Instead of a requirements.txt file, Heroku also supports docker images in two ways:

- Heroku Container Registry via e.g. `heroku container:push web`
- via Dockerfiles in your `heroku.yml`  file (see below)
  - EITHER specify run-section OR specify CMD in Docker
  - `Procfile`  will be ignored in both cases!


```yaml
# Example heroku.yml
build:
  docker:
    web: Dockerfile
run:
  web: bundle exec puma -C config/puma.rb
```

Also see https://towardsdatascience.com/heroku-docker-in-10-minutes-f4329c4fd72f
