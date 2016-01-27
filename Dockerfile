FROM coolsoft/debian-java

RUN cd /tmp && \
    wget -O /tmp/nexus-bundle.tar.gz http://download.sonatype.com/nexus/3/nexus-3.0.0-m7-unix.tar.gz && \
    tar -zxf /tmp/nexus-bundle.tar.gz -C /usr/local && \
    mv /usr/local/nexus-3.0.0-* /usr/local/nexus && \
    mkdir -p /usr/local/sonatype-work/nexus/logs && \
    touch /usr/local/sonatype-work/nexus/logs/nexus.log && \
    rm /tmp/nexus-bundle.tar.gz && \
    useradd -m nexus && \
    chown -R nexus /usr/local/sonatype-work && \
    chown -R nexus /usr/local/nexus

VOLUME /usr/local/sonatype-work/nexus
VOLUME /usr/local/nexus/data
EXPOSE 8081

USER nexus
WORKDIR /usr/local/nexus/bin
CMD ["./nexus", "run"]