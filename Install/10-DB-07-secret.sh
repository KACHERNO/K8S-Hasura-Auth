kubectl create secret generic timescale-secret \
--from-literal=PGHOST=timescaledb \
--from-literal=PGPORT=5432 \
--from-literal=PGDATABASE=postgres \
--from-literal=PGUSER=postgres \
--from-literal=PGPASSWORD=postgres

