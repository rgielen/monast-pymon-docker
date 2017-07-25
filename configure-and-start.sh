#!/usr/bin/env bash

envsubst < /pymon/monast.conf.template > /pymon/config/monast.conf
exec /pymon/monast.py --config /pymon/config/monast.conf "$@"
