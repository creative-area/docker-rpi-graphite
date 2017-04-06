# Docker RPI Graphite

A Raspberry (ARM) Docker image to provide ready to use Graphite stack (Carbon + Whisper + Graphite-API).

```bash
docker run --name graphite -d creativearea/rpi-graphite
```

*[Graphite Carbon and Whisper](http://graphite.readthedocs.io/) are built from source. [Graphite-API](https://graphite-api.readthedocs.io) is installed with `pip` and is behind a `gunicorn` server. Stack is managed by `Supervisor`.*

## Ports

- 2003 : carbon line receiver
- 2004 : carbon pickle receiver
- 7002 : carbon cache query
- 8000 : graphite-api

## Volumes

- /opt/graphite/storage/whisper
- /opt/graphite/conf
