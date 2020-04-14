## Running the production version
You want to be running the production version every time you edit the boxes list for real.

```bash
MIX_ENV=prod PORT=4000 mix phx.server
```

Note: if you've made changes to static assets you should first run:
```bash
mix phx.digest
```

## Backup the db
```bash
pg_dump -U postgres -d boxes_prod --data-only > ~/home/Vault/Boxes/boxes_prod_`date +"%Y%m%d"`.sql
```

## Restore a backup

```bash
MIX_ENV=prod mix PORT=4000 ecto.reset
cat ~/home/Vault/Boxes/boxes_prod_20200414.sql | psql -U postgres -d boxes_prod
```
