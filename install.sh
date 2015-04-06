#!/bin/bash

gem build dspace-rest-client.gemspec \
&& \
gem install --local dspace-rest-client-0.0.1.gem
