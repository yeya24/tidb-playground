FROM bitnami/minideb:jessie

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENV TIDB_VERSION

RUN  curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh && ln -s /root/.tiup/bin/tiup /bin/tiup

RUN tiup install tidb:${TIDB_VERSION} pd:${TIDB_VERSION} tikv:${TIDB_VERSION} playground

CMD tiup playground ${TIDB_VERSION} --db.host 0.0.0.0 --pd.host 0.0.0.0 --tiflash 0
