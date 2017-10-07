# SDF CLI Docker Image
# AUTHOR                Alex Manatskyi
# VERSION               1.0

FROM alpine

LABEL maintainer="Alex Manatskyi <aleksanderson@gmail.com>"

ENV SDFCLI_URL=https://system.netsuite.com/download/ide/update_17_2/plugins/com.netsuite.ide.core_2017.2.0.jar \
    SDFCLI_SUPL_URL=https://system.netsuite.com/core/media/media.nl?id=87134768&c=NLCORP&h=8e8f2820ee2d719ac411&id=87134768&_xt=.gz&_xd=T&e=T \
    SDFCLI_FOLDER=/webdev/sdf/cli
    
ENV PATH $PATH:$SDFCLI_FOLDER

RUN apk --update add \
    bash \
    openjdk7-jre \
    maven \
    #to be able to use HTTPS via wget
    ca-certificates wget

ENV JAVA_HOME "/usr/lib/jvm/default-jvm/jre/"

WORKDIR $SDFCLI_FOLDER

RUN wget $SDFCLI_URL && \
    wget -qO- $SDFCLI_SUPL_URL | tar xvz && \
    mvn exec:java -Dexec.args= && \
    #removing Windows based CR char causing issues in UNIX based systems
    sed -i -e 's/\r$//' sdfcli sdfcli-createproject

ENTRYPOINT ["/bin/bash", "-c"]

