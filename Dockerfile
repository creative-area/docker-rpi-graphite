FROM resin/rpi-raspbian

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python-dev libcairo2-dev libffi-dev python-pip build-essential git python-twisted-core supervisor

RUN git clone https://github.com/graphite-project/carbon.git /usr/local/src/carbon
RUN git clone https://github.com/graphite-project/whisper.git /usr/local/src/whisper

RUN cd /usr/local/src/whisper && python setup.py install
RUN cd /usr/local/src/carbon && python setup.py install

COPY conf/carbon.conf /opt/graphite/conf/carbon.conf
COPY conf/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
COPY conf/storage-aggregation.conf /opt/graphite/conf/storage-aggregation.conf
COPY conf/graphite-api.yaml /etc/graphite-api.yaml
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN pip install gunicorn graphite-api

EXPOSE 2003
EXPOSE 2004
EXPOSE 7002
EXPOSE 8000

VOLUME ["/opt/graphite/conf"]
VOLUME ["/opt/graphite/storage/whisper"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
