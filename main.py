from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def hello():
    return {"Hello": "World"}


@app.get("/name/{name}")
def hello_name(name: str):
    return {"Hello": name}
