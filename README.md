# Mse

**TODO: Add description**

## Provisioning a server


Creating a Digital Ocean droplet with docker-machine:

```sh
docker-machine create --driver=digitalocean
--digitalocean-access-token=$DIGITAL_OCEAN_TOKEN --digitalocean-size=512mb
docker-test
```

Set it as our active machine locally:

```sh
eval $(docker-machine env docker-test)
```

Deploy:

```sh
docker-compose up -d
```
