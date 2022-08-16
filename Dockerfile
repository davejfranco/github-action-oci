FROM python:3.9-alpine3.14

#app directory
WORKDIR /app
#demo user
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup -g ${GROUP_ID} demo \
 && adduser -D demo -u ${USER_ID} -g demo -G demo -s /bin/sh

#copy files
COPY --chown=demo . /app/

#install depedencies
RUN apk add --no-cache --virtual .build-deps gcc libc-dev make \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps gcc libc-dev make

USER demo

#entrypoint
CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]




