FROM rabbitmq:3.13-management

LABEL maintainer="production"

# Enable plugins
RUN rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_prometheus \
    rabbitmq_shovel \
    rabbitmq_shovel_management

# Copy configuration
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY enabled_plugins /etc/rabbitmq/enabled_plugins

# Create persistent directories
RUN mkdir -p /var/lib/rabbitmq \
    && chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

VOLUME ["/var/lib/rabbitmq"]

# Expose ports
EXPOSE 5672   
EXPOSE 15672  
EXPOSE 15692  

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=5 \
    CMD rabbitmq-diagnostics -q ping

# Environment tuning
ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS="+S 2:2 +sbwt none +sbwtdcpu none +sbwtdio none"

USER rabbitmq

CMD ["rabbitmq-server"]