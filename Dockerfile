FROM python:3-alpine
LABEL   app.authors="Arturo C. <arturplur@gmail.com>" \
        app.name="Trading app" \
        app.description="Trading strategies web app"


# https://github.com/brettkromkamp/contextualise/issues/77
RUN apk update \
    && pip3 install --upgrade pip \
    && apk add \
    #gcc musl-dev 
    python3-dev py3-setuptools libffi libffi-dev 
    #openssl-dev git \
    #&& pip3 install poetry \
    #&& pip3 install --no-build-isolation pendulum==2.1.0


# Install Python modules
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf ~/.cache/pip

WORKDIR /app

COPY . /app/

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]