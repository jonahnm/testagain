FROM haxe:3.4.7
RUN apt-get update && apt-get -y install sudo
COPY ./requirements.hxml /
RUN yes | haxelib install requirements.hxml
RUN yes | haxelib run lime setup
RUN lime setup flixel
RUN yes | lime setup linux
WORKDIR /project
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
