# Loadbalancer-modul

Denne modulen oppretter en intern Azure Load Balancer for database-VM-ene.

Med denne modulen settes det opp at hvis en sql database er nede skal det redirecte web tjenesten til en den andre sql databasen.

## Input-variabler

- `location`
- `resource_group_name`
- `vnet_id`
- `subnet_id`
- `backend_pool_ips`

## Bruk

Kalles fra root-modulen og får subnet/vnet/ips fra de andre modulene.