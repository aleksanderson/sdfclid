# SDF CLI Docker Image
# AUTHOR                Alex Manatskyi
# VERSION               1.0

FROM java:7-jre

LABEL maintainer="Alex Manatskyi <aleksanderson@gmail.com>"

ENV SDFCLI_URL=https://system.netsuite.com/download/ide/update_17_1/plugins/com.netsuite.ide.core_2017.1.2.jar \
    SDFCLI_SUPL_URL=https://system.netsuite.com/core/media/media.nl?id=78304610&c=NLCORP&h=7815ede561a186622753&_xd=T&_xt=.bin \
    SDFCLI_FOLDER=/webdev/sdf/cli
    
ENV PATH=$PATH:$SDFCLI_FOLDER

COPY ./docker-entrypoint.sh /

ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN mkdir -p $SDFCLI_FOLDER && \ 
    cd $SDFCLI_FOLDER && \
    wget $SDFCLI_URL && \
    wget -qO- $SDFCLI_SUPL_URL | tar xvz && \
    mvn exec:java -Dexec.args= && \
    chmod +x sdfcli sdfcli-createproject && \
    #removing Windows based CR char causing issues in UNIX based systems
    sed -i -e 's/\r$//' sdfcli sdfcli-createproject

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]

