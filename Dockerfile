FROM python:3
RUN mkdir app

EXPOSE 5000
COPY ./app ./app

RUN pip install -r ./app/requirements.txt
CMD ["python", "./app/web_app.py"]