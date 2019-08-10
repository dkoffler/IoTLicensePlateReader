FROM balenalib/raspberrypi3:jessie


#docker run -it --privileged --entrypoint /bin/bash --name=rpi_cam nieleyde/rpi-webcam


#https://github.com/balena-io-playground/balena-cam/blob/master/balena-cam/Dockerfile.template

#https://github.com/arijusg/rpi-docker-camera
#RUN apt-get update \
#	&& apt-get install -y \
#    		build-essential \
#		cmake \
    		curl \
  #  		git \
 #	&& apt-get clean \
 #	&& rm -rf /var/lib/apt/lists/*

#RUN apt-get install build-essential libjpeg8-dev imagemagick libv4l-dev cmake

#Enable balena images to access dynically plugged devices. Container must also be run in privileged mode
ENV UDEV=1

RUN install_packages \
    build-essential \
    cmake \
    curl \
    git \
    libjpeg8-dev \
    imagemagick \
    libv4l-dev \
    gcc \
    g++

#Build userland components for access to camera
WORKDIR /
RUN git clone --depth 1 https://github.com/raspberrypi/userland.git

WORKDIR /userland
RUN chmod +x buildme
RUN ./buildme    



#run cmd: docker run --name streamer --device=/dev/vchiq -dp 8080:8080 mystreamer