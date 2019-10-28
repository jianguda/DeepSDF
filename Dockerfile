FROM debian:9

VOLUME ["/data", "/v2"]

RUN apt-get update && apt-get install -yq \
    python3 \
    python3-pip \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libglew-dev \
    libwayland-dev \
    libxkbcommon-dev \
    wayland-protocols

RUN pip3 install torch trimesh numpy scipy scikit-image plyfile

ENV PANGOLIN_WINDOW_URI=headless://

WORKDIR /DeepSDF

COPY . /DeepSDF

# install docker-ce
# wget https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_18.09.9~3-0~debian-stretch_amd64.deb
# sudo dpkg -i docker-ce_18.09.9~3-0~debian-stretch_amd64.deb

# build image
# docker build --tag=deepsdf .
# docker tag deepsdf ycaxgjd/deepsdf:1.0
# docker login
# docker push ycaxgjd/deepsdf:1.0

# use image
# docker pull ycaxgjd/deepsdf:1.0
# docker run -v data:/data -v ShapeNetCore.v2:/v2 ycaxgjd/deepsdf:1.0 python3 ...
