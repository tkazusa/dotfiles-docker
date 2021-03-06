# Development environment for Python 3.9 



## Requirement
- Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
- Docker >= 20.10.07

## Deployment
Launch an EC2 instance with Ubuntu 20.04 LTS AMI then access to the EC2 instance via SSH. Sample `.ssh/config` is following. 


## On EC2

```
$ git clone https://github.com/tkazusa/dotfiles-docker.git
```

Modify `setup.sh` for EC2 deployment.
```bash
# For remote EC2.
$HOME=/home/ubuntu
DOTDIR=/home/ubuntu/dotfiles-docker/dotfiles
```

Then, run `setup.sh`

```
$ cd dotfiles-docker/dotfiles
$ sudo bash setup.sh
```

Run `sudo `

## On Docker
NOT WORKING: based on the [article](https://k-hyoda.hatenablog.com/entry/2020/11/29/180943).
```
Host aws-dev
    HostName ec2-X-XXX-XX-XXX.compute-1.amazonaws.com
    User ubuntu
    IdentityFile ~/.ssh/XXXXXX-key.pem

Host aws-dev-docker
    Hostname 127.0.0.1
    User root
    Port 10000
    ProxyCommand ssh -W %h:%p aws-dev
```
Run ssh command.

```
$ ssh aws-dev
```

Launch the Docker container with following commands.

```
$ git clone https://github.com/tkazusa/dotfiles-docker.git
$ cd dotfiles-docker
$ docker build -t dev-docker .
$ docker run -d -p 10000:22 dev-docker
$ docker run -d -p 10000:22 /home/ubuntu/aws-dev-docker:/root/aws-dev-docker dev-docker
```

## Attaching to the Docker container
After launching the dev-docker container, you can access to it via SSH or VSCode Remote SSH.

```
$ ssh root@127.0.0.1 -p 10000
```

If you failed to login the container due to key-host issue, update your known_hosts file or delete the key in the known_hosts file.

```
ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[127.0.0.1]:10000"
```

## Python Develop Environment

### Switching python versions between environments
To switch between Python versions, it is recommended to use pyenv.
Details are in [the poetry document](https://python-poetry.org/docs/managing-environments/). 
```
$ pyenv install 3.6.9
$ pyenv local 3.6.9
```

## VSCode Extension

### Python extension
- [flake8](https://flake8.pycqa.org/en/latest/index.html#): Checking files for error (Ignore:`W293`, `W504`) 
- [isort](https://pycqa.github.io/isort/): Orgnizing imports.
- [black](https://black.readthedocs.io/en/stable/): Formatting according to PEP8

### Pylance extension
- [Pylance](https://github.com/microsoft/pylance-release): Checking files for type hint. Enabled as strict mode.

### Python Docstring Generator extension
- [Python Docstring Generator](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring):Generating a docstring following "Google" style.

