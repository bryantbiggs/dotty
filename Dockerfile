FROM registry.fedoraproject.org/f31/fedora-toolbox:31

LABEL name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Personal base image for creating Fedora toolbox containers" \
      maintainer="Bryant Biggs <bryantbiggs@gmail.com>"

COPY code code

# RUN dnf update \
RUN dnf install libX11-xcb -y 
    # \
    # dnf clean all

# Install VSCode
COPY code .
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc \
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
    dnf install code -y \
    dnf clean all 

RUN code/extensions.sh \
    rm -rf code 

CMD /bin/sh
