#Docker container for access to Raspberry Pi camera and setup of MJPG streaming
#Based on MJPEG Streamer from https://github.com/jacksonliam/mjpg-streamer
#Author: Daniel Koffler, 2019

FROM balenalib/raspberrypi3:jessie

LABEL maintainer="dkoffler@rsmexperts.com"
LABEL description="Raspberry Pi Jesse based container to make Pi camera video stream available via MJPEG Streamer"

ENV UDEV=1

RUN install_packages \
    build-essential \
    cmake \
    git \
    libjpeg8-dev \
    libraspberrypi-dev

# Get mjpg-streamer code from Github.

WORKDIR /
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git

WORKDIR /mjpg-streamer/mjpg-streamer-experimental
RUN make && make install && chmod +x docker-start.sh

# Expose the MJPG Streaming web interface on port 8080
EXPOSE 8080/TCP

ENTRYPOINT ["/mjpg-streamer/mjpg-streamer-experimental/docker-start.sh", "output_http.so -w ./www"]

#Adjust parameters of video capture using the raspicam input
CMD ["input_raspicam.so -x 1280 -y 720 -fps 15"]

# You must make the camera on the host available to this container via the "docker run" command.
#  This is done via the --device parameter as shown below.
# Simplest docker run example:
# docker run --device=/dev/vchiq rpi_streamer
# You probably actually want to run something more along the lines of:
# docker run --name mystreamer --device=/dev/vchiq -dp 8080:8080 rpi_streamer