# Monast Pymon Docker Image

This is a dockerized version of the Python monitor of the [Monast Asterisk Monitor Project](https://dagmoller.github.io/monast/).

When run, the following environment variables can be adjusted:
  * `BIND_HOST=0.0.0.0` Bind Pymon to specific interface
  * `BIND_PORT=5039` Pymon Port to use (will be exposed)
  * `ASTERISK_HOST=localhost` Asterisk host address
  * `ASTERISK_PORT=5038` Asterisk AMI port
  * `AMI_USERNAME=admin` Configured AMI user name in manager.conf
  * `AMI_PASSWORD=admin` Configured AMI user secret in manager.conf
  * `DEFAULT_CONTEXT=default` Default telephone context
  * `TRANSFER_CONTEXT=default` Default transfer context 
  * `MEETME_CONTEXT=default` Default meetme context
  * `USER_ADMIN_SECRET=admin` Secret for Pymon user `admin`
  * `USER_AGENT_SECRET=agent` Secret for Pymon user `agent`
  * `ADDITIONAL_CONFIG_LINES=""` Add more lines to config file
  
See [Dockerfile](Dockerfile) and [monast.conf.template](monast.conf.template) for more details.

