kubectl run test-psql --image=postgres --restart=Never \
--env="PGHOST=$(kubectl get secret timescale-secret -o=jsonpath='{.data.PGHOST}' | base64 --decode)" \
--env="PGPORT=$(kubectl get secret timescale-secret -o=jsonpath='{.data.PGPORT}' | base64 --decode)" \
--env="PGDATABASE=$(kubectl get secret timescale-secret -o=jsonpath='{.data.PGDATABASE}' | base64 --decode)" \
--env="PGUSER=$(kubectl get secret timescale-secret -o=jsonpath='{.data.PGUSER}' | base64 --decode)" \
--env="PGPASSWORD=$(kubectl get secret timescale-secret -o=jsonpath='{.data.PGPASSWORD}' | base64 --decode)" \
-- sleep infinity

