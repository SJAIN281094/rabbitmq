FROM rabbitmq:3.13-management-alpine

RUN rabbitmq-plugins enable --offline \
    rabbitmq_prometheus \
    rabbitmq_shovel \
    rabbitmq_shovel_management

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY enabled_plugins /etc/rabbitmq/enabled_plugins

USER rabbitmq
CMD ["rabbitmq-server"]
