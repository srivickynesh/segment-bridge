To Build and run container
```
podman build -t test -f Dockerfile_test

podman run -it --entrypoint /bin/sh localhost/test:latest
```

Step 1:
We need to run this command as part of inittab to create cluster at the time of creating the container
```
kwokctl create cluster --name host
```

Step 2:
Single proxy to manage these clusters
Handle multiple cluster creation and signal trap during shutdown
