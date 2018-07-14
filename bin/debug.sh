#!/bin/bash

: ${SUSPEND:='n'}

set -e

mvn clean package
export KAFKA_JMX_OPTS="-Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=${SUSPEND},address=5005"
export CLASSPATH="$(find target/kafka-connect-tester-0.1.0-package/share/java -type f -name '*.jar' | tr '\n' ':')"

#sed -e "s/MY_MACHINE_IP/$(hostname)/g" config/connect-standalone.properties > config/connect-standalone.new.properties

connect-standalone config/connect-standalone.new.properties config/MySinkConnector.properties config/MySourceConnector.properties
