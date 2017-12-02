FROM fedora

RUN curl -O http://iris.dot.state.mn.us/rpms/iris-4.59.1-1.noarch.rpm
RUN dnf install -y iris-4.59.1-1.noarch.rpm
RUN dnf install -y procps
RUN su - postgres -c 'initdb'

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]

CMD java -server -Xmx1024m -XX:+UseG1GC -jar /usr/share/java/iris-server-4.59.1/iris-server-4.59.1.jar
