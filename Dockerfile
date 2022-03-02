FROM python:3.9
COPY ./requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt
COPY ./app ./app
# heroku requires to run on $PORT variable, see https://stackoverflow.com/a/59400446/2135504
CMD uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-5000}
