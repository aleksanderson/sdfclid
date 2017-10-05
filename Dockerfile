# SDF CLI Docker image
# AUTHOR                Alex Manatskyi
# VERSION               0.1

ARG JAVA_VERSION=3-jdk-7
FROM maven:${JAVA_VERSION}

LABEL maintainer="aleksanderson@gmail.com"

ENV SDFCLI_URL=https://system.netsuite.com/download/ide/update_17_1/plugins/com.netsuite.ide.core_2017.1.2.jar \
    SDFCLI_SUPL_URL=https://system.netsuite.com/core/media/media.nl?id=78304610&c=NLCORP&h=7815ede561a186622753&_xd=T&_xt=.bin \
    SDFCLI_FOLDER=/webdev/sdf/cli
    
ENV PATH=$PATH:$SDFCLI_FOLDER

COPY ./docker-entrypoint.sh /

RUN mkdir -p $SDFCLI_FOLDER && \ 
    cd $SDFCLI_FOLDER && \
    wget $SDFCLI_URL && \
    wget -qO- $SDFCLI_SUPL_URL | tar xvz && \
    # building maven dependencies preserving it in the image
    #mvn exec:java -Dexec.args= -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve && \
    mvn exec:java -Dexec.args= && \
    chmod +x sdfcli sdfcli-createproject && \
    #removing Windows based CR char causing issues in UNIX based systems
    sed -i -e 's/\r$//' sdfcli sdfcli-createproject

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]

