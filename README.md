# About

- [x] simple Docker on Heroku
  - this works (see branch "use_Dockerfile"), but the deployment process becomes significantly longer (~1-2minutes instead of ~20seconds)
  - Maybe the other process is also longer
- [ ] simple webapp without Docker on Heroku
- [ ] streamlit local
- [ ] streamlit with requirements on heroku?

## Simple Docker on Heroku

### Run Docker locally

```bash
IMAGE_NAME="streamlit-heroku-test"
docker build -t $IMAGE_NAME . 

PORT=80
docker run --rm -p 80:80 $IMAGE_NAME
```

### Deploy to heroku

https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#setting-build-time-environment-variables

```bash
# git commit ! (seems like heroku needs this)

heroku login
heroku create # creates an app
heroku stack:set container  # stack=OS (by default Heroku-20 based on ubuntu 20.04 till 2025)
git push heroku master

heroku ps:scale web=1
heroku ps # crashed :/
heroku open
heroku logs --tail
```

## Simple webapp without heroku

Need...
- a Procfile to define what to execute
- optional: `runtime.txt` to specfiy python runtime different than default (python-3.9.10)
- optional: `heroku.yml` to specify build process -> delete
- delete `Dockerfile`
- set "stack"=OS (because currently still container)

```bash
heroku stack # show available and selected stacks
heroku stack:set heroku-20
```