#!/usr/bin/env bash

shelldir=$(cd `dirname $0`; pwd)
cd "$shelldir"

./bin/Debug/skynet app/config.lua