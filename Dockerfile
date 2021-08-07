FROM ubuntu:21.04
LABEL   app.authors="Arturo C. <arturplur@gmail.com>" \
        app.name="Trading app" \
        app.description="Trading strategies web app"

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="America/Lima" apt-get install -y tzdata

# https://github.com/FNNDSC/ubuntu-python3/blob/master/Dockerfile
RUN apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  #https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
  && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata \
  && rm -rf /var/lib/apt/lists/*

# Install Python modules
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf ~/.cache/pip

WORKDIR /app

COPY . /app/

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]