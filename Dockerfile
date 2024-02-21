FROM docker.elastic.co/logstash/logstash:8.11.0
COPY logstash-output-mysql_metrics-0.1.0.gem /tmp
COPY logstash.yml /usr/share/logstash/config/logstash.yml
RUN logstash-plugin install /tmp/logstash-output-mysql_metrics-0.1.0.gem
