# Pathway Tools Docker - PythonCyc
In order to use PythonCyc, I decided to fork the [BioCyc Docker Repo](https://github.com/biorack/pathway_tools_docker) and alter the Dockerfile so that it will run as a server that PythonCyc can communicate with.

## Pathway Tools Docker Setup
The Docker image is based on **Ubuntu:22.04**, updated to have the required support libraries. Currently, the Dockerfile assumes that it is installing version 26.0 of the pathway tools, and expects you to provide the **pathway-tools-26.0-linux-64-tier1-install** installer in this directory.

Build the container with the following command:

```
docker build -t biocyc/ptools:26.0
```

You can run the container with this command, choosing to bind the Python Server (5008) to whatever port you want on your local machine:

```
docker run -d -p <host-port>:5008 biocyc/ptools:26.0
```

## PythonCyc
To get PythonCyc to communicate with the Pathway Tools docker container, you have to set some configuration parameters. 
If the container is running on your local machine, you can use `0.0.0.0` as the host name, otherwise provide the URL/IP to the server/machine. 
For setting the host port, use the same port specified in the `docker run` command used above:

```python
from pythoncyc import config

config.set_host_name('0.0.0.0')  # If running on local machine
config.set_host_port(PTOOLS_HOST_PORT)
```

Then you can verify it is working by executing the following commands:
```python
from pythoncyc import select_organism

meta = select_organism('meta')
pwys = meta.all_pathways()
print(pwys)
```