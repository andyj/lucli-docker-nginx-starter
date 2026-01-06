FROM eclipse-temurin:17-jre

ARG LUCLI_JAR_URL

ENV LUCLI_HOME=/opt/lucli/home
WORKDIR /opt/lucli

COPY lucli.jar /opt/lucli/lucli.jar

RUN if [ -n "${LUCLI_JAR_URL}" ]; then \
        apt-get update \
        && apt-get install -y --no-install-recommends curl ca-certificates \
        && curl -fsSL "${LUCLI_JAR_URL}" -o /opt/lucli/lucli.jar \
        && apt-get purge -y --auto-remove curl \
        && rm -rf /var/lib/apt/lists/* ; \
    fi

COPY docker/lucli/entrypoint.sh /usr/local/bin/lucli-entrypoint.sh

RUN chmod +x /usr/local/bin/lucli-entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/lucli-entrypoint.sh"]
