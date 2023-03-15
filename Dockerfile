FROM python:3.10-slim
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --assume-yes --quiet --no-install-recommends aria2 wget p7zip p7zip-full unrar-free libmagic1 git python3-dev gcc
RUN wget -qO /usr/bin/qbittorrent-nox https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/aarch64-qbittorrent-nox
RUN wget -qO /tmp/ffmpeg.zip https://github.com/ffbinaries/ffbinaries-prebuilt/releases/download/v4.4.1/ffmpeg-4.4.1-linux-arm-64.zip
RUN wget -qO /tmp/ffprobe.zip https://github.com/ffbinaries/ffbinaries-prebuilt/releases/download/v4.4.1/ffprobe-4.4.1-linux-arm-64.zip
RUN 7z x /tmp/ffmpeg.zip -o/tmp -y
RUN 7z x /tmp/ffprobe.zip -o/tmp -y
RUN cp /tmp/ffmpeg /tmp/ffprobe /usr/bin
RUN chmod ugo+x /usr/bin/qbittorrent-nox /usr/bin/ffmpeg /usr/bin/ffprobe
RUN rm /tmp/ffmpeg /tmp/ffprobe /tmp/ffmpeg.zip /tmp/ffprobe.zip
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN python -m pip install --upgrade pip
RUN python -m pip install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python", "-u", "main.py"]
