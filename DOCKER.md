# Building Cirrus in Docker

Update the submodules thingies:

```sh
git submodule update --init --recursive
```

Build:

```sh
docker build --platform linux/amd64 -t cirrus-builder .
```

Powershell:

```powershell
docker run --rm --platform linux/amd64 --mount "type=bind,source=$($PWD.Path),target=/src" cirrus-builder
```

Linux:

```sh
docker run --rm --platform linux/amd64 --mount "type=bind,source=$(pwd),target=/src" cirrus-builder
```