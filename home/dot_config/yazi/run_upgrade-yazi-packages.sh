#! /usr/bin/env bash

ya pkg upgrade &> /dev/null && echo "Yazi packages successfully upgraded" || echo "!!! ya pkg upgrade did not complete successfully!"
