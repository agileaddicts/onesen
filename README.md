# agileaddicts/onesen

## Connecting to staging/prod database

From within the root folder, run

```
flyctl proxy 6543:5432 -a onesen-postgres
```

and connect to the database on port 6543.
