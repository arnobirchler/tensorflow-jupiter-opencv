# Dockerfile with tensorflow gpu support on python3, opencv3.3
FROM jjanzic/docker-python3-opencv
FROM tensorflow/tensorflow:latest-py3-jupyter
RUN mkdir /home/models
RUN pip install Pillow opencv-python 
RUN apt-get update
RUN apt-get install -y git libsm6 libxext6 libxrender-dev curl unzip

COPY models /home/models

RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protoc-3.9.1-linux-x86_64.zip > protoc.zip
RUN mkdir /opt/protoc
RUN unzip protoc.zip -d /opt/protoc
RUN rm protoc.zip
ENV PATH="/opt/protoc/bin:${PATH}"
RUN (cd /home/models/research && protoc --python_out=. object_detection/protos/*)

EXPOSE 8888
