# FROM pandoc/latex:latest-ubuntu
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y wget unzip git curl poppler-utils dos2unix python3-setuptools python3-pip fontconfig

RUN wget https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-1-amd64.deb
RUN dpkg -i pandoc-2.10.1-1-amd64.deb

RUN mkdir -p /usr/share/fonts/opentype/noto

RUN wget -nv https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJK-Regular.ttc.zip
RUN unzip NotoSansCJK-Regular.ttc.zip -d NotoSansCJK-Regular
RUN cp NotoSansCJK-Regular/NotoSansCJK-Regular.ttc /usr/share/fonts/opentype/noto

RUN wget -nv https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJK-Bold.ttc.zip
RUN unzip NotoSansCJK-Bold.ttc.zip -d NotoSansCJK-Bold
RUN cp NotoSansCJK-Bold/NotoSansCJK-Bold.ttc /usr/share/fonts/opentype/noto

RUN fc-cache -f -v

RUN rm -rf pandoc-2.10.1-1-amd64.deb NotoSansCJK-Bold.ttc.zip NotoSansCJK-Bold/ NotoSansCJK-Regular.ttc.zip NotoSansCJK-Regular/

RUN python3 -m pip install pillow psutil

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ioi-2017/tps/master/online-installer/install.sh)"

# RUN apt install -y tzdata
# ENV TZ="Asia/Taipei"
# RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
# RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt install -y texlive-xetex

CMD ["bash"]
