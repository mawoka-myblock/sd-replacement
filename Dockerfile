FROM python:3.10-bullseye

RUN mkdir /app
WORKDIR /app
COPY server/ /app/server/
COPY Pipfile* /app/
RUN pip install pipenv && pipenv install --system && wget https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt -q -O words.txt
EXPOSE 8000
ENV PYTHONPATH=/app
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:8000", "-w",  "1", "server:app"] 