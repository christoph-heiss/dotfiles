#!/usr/bin/env bash

set -e

WITH_GUI=y

source ./common.sh


arch_generic_pre
generic_pre

arch_generic_post
generic_post
