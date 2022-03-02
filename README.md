# About

This repository contains three *working* Heroku deployment options:
- FastAPI App and Docker stack (see branch "fastapi-in-docker")
  - This works nicely, but the deployment process seems significantly longer than with the default Heroku stack (i.e. 2 minutes instead of 20 seconds). Moreover, I assue that the default Heroku stack is in some way optimized. Therefore, use the default stack after all.
- FastAPI App and default Heroku-20 stack (see branch "fastapi")
- streamlit App and default Heroku-20 stack (see branch "streamlit")


## FastAPI App and Docker

### Run Docker locally

```bash
IMAGE_NAME="fastapi-heroku-test"
docker build -t $IMAGE_NAME . 

PORT=80  # variable in Dockerfile CMD for Heroku to work
docker run --rm -p 80:80 $IMAGE_NAME
```

### Deploy to heroku

```bash
# git commit (seems like heroku needs this)

heroku login
heroku create
heroku stack:set container  # stack=~OS (by default Heroku-20 based on ubuntu 20.04 till 2025)
git push heroku master

heroku ps:scale web=1
heroku ps
heroku open
heroku logs --tail
```

## FastAPI App and default Heroku-20 stack

Changes compared to 
- add: a Procfile to define what to execute
- add optionally: `runtime.txt` to specfiy python runtime different than default (python-3.9.10)
- remove `heroku.yml` to specify build process
- remove `Dockerfile`
- set "stack"=OS (because currently still container)

```bash
heroku stack # show available and selected stacks
heroku stack:set heroku-20

# to open locally, need local venv and then:
heroku local
```

## Streamlit App and default Heroku-20 stack

To run locally simply execute `streamlit run app.py`.

To [deploy Streamlit](https://docs.streamlit.io/knowledge-base/deploy/deploy-streamlit-heroku-aws-google-cloud) on e.g. Herou:
- create a `setup.sh` file like below
- in your `Procfile` use the following line: `sh setup.sh && streamlit run main.py`

```bash
# content of setup.sh
mkdir -p ~/.streamlit

echo "[server]
headless = true
port = $PORT
enableCORS = false
" > ~/.streamlit/config.toml
```