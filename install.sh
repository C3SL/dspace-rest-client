#!/bin/bash

gemspec_file='dspace_rest_client.gemspec'

if [ ! -e ${gemspec_file} ]; then
  echo -e "ERRO! O arquivo ${gemspec_file} nao foi encontrado."
  exit 1
fi

name=$(grep -m 1 "s\.name" ${gemspec_file} | cut -d "=" -f2 | sed "s#\ ##g; s#'##g")
version=$(grep -m 1 "s\.version" ${gemspec_file} | cut -d "=" -f2 | sed "s#\ ##g; s#'##g")

gem build ${gemspec_file} && gem install --local ${name}-${version}.gem
