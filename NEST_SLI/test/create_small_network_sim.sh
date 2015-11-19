# -*- coding: utf-8 -*-
#
# run_microcircuit.sh
#
# This file is part of NEST.
#
# Copyright (C) 2004 The NEST Initiative
#
# NEST is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# NEST is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with NEST.  If not, see <http://www.gnu.org/licenses/>.

#!/bin/bash



# Creates a small scale version of the microcircuit, which can be tested on a 
# single processor. Requires NEST to be installed & findable on the PATH 
# using: which nest
#
# Adapted from ../run_microcircuit.sh


path=`pwd`/data


# path for nest
nest_path=`which nest`

echo "Found NEST at $nest_path"

# copy simulation scripts to output directory
mkdir -p $path

cp '../user_params.sli' $path
cp '../spike_analysis.py' $path
subs1='s/\/path_to_data\/data/'${path//\//\\\/}'/g'
sed -i -e $subs1 trial_run/user_params.sli
subs1='s/\/path_to_nest_install_folder\/bin\/nest/'${nest_path//\//\\\/}'/g'
sed -i -e $subs1 trial_run/user_params.sli

cp '../network_params.sli' $path

sed -i -e s/area.1.def/'area 0.05 def'/g trial_run/network_params.sli

cp '../sim_params.sli' $path
cp '../microcircuit.sli' $path
cd $path

# create sim_script.sh
echo > sim_script.sh
chmod 755 sim_script.sh


echo "$nest_path $path/microcircuit.sli" >> sim_script.sh

echo "Created script (sim_script.sh) to run small scale simulation in " $path


