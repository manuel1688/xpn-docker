#!/bin/bash
#set -x

#
#  Copyright 2019-2021 Saul Alonso Monsalve, Felix Garcia Carballeira, Jose Rivadeneira Lopez-Bravo, Alejandro Calderon Mateos,
#
#  This file is part of U20 proyect.
#
#  U20 is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  U20 is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with U20.  If not, see <http://www.gnu.org/licenses/>.
#




#
# Usage
#

if [ $# -eq 0 ]; then
	$0 help
	exit
fi


#
# check docker
#

docker -v >& /dev/null
status=$?
if [ $status -ne 0 ]; then
	echo ": docker is not found in this computer."
	echo ": * Did you install docker?."
	echo ":   Please visit https://docs.docker.com/get-docker/"
	echo ""
	exit
fi


#
# for each argument, try to execute it
#

while (( "$#" ))
do
	arg_i=$1
	case $arg_i in
		build)
			# Check params
			if [ ! -f xpn-dockerfile ]; then
			    echo ": The xpn-dockerfile file is not found."
			    echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
			    echo ""
			    exit
			fi

			echo "Building initial image..."
			docker image build -t expand -f xpn-dockerfile .
		;;

		start)
			shift

			echo "Building containers..."
			docker-compose -f xpn-dockercompose.yml up -d --scale node=$1
			if [ $? -gt 0 ]; then
				echo ": The docker-compose command failed to spin up containers."
				echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
				echo ""
				exit
			fi
		;;

		bash)
			shift
			CO_ID=$1
			CO_NC=$(docker ps -f name=node_ -q | wc -l)
			if [ $CO_ID -lt 1 ]; then
				echo "ERROR: Container ID $CO_ID out of range (1...$CO_NC)"
				shift
				continue
			fi
			if [ $CO_ID -gt $CO_NC ]; then
				echo "ERROR: Container ID $CO_ID out of range (1...$CO_NC)"
				shift
				continue
			fi

			echo "Executing /bin/bash on container $CO_ID..."
			CO_NAME=$(docker ps -f name=node_ -q | head -$CO_ID | tail -1)
			docker exec -it $CO_NAME /bin/bash
		;;

		stop)
			echo "Stopping containers..."
			docker-compose -f xpn-dockercompose.yml down
			if [ $? -gt 0 ]; then
				echo ": The docker-compose command failed to stop containers."
				echo ": * Did you execute git clone https://github.com/acaldero/u20-docker.git?."
				echo ""
				exit
			fi
      ./clean_conf.sh
		;;
   
   		swarm-start)
			# Setup number of containers
			NC=$2
			if [ $# -lt 1 ]; then
				 NC=1
			fi
      
      shift
	
			# Check params
			if [ -f .xpn_worksession ]; then
				echo ": There is an already running xpn container."
				echo ": * Please stop first."
				echo ": * Please see ./xpn.sh help for more information."
				echo ""
				exit
			fi
	
			# Start container cluster
			docker stack deploy --compose-file xpn-dockercompose_swarm.yml xpn
			if [ $? -gt 0 ]; then
				echo ": The docker stack deploy command failed to spin up containers."
				echo ""
				exit
			fi
			docker service scale xpn_node=$NC
	
			# Container cluster files...
			CONTAINER_ID_LIST=$(docker service ps xpn_node -f desired-state=running -q)
			docker inspect -f '{{range .NetworksAttachments}}{{.Addresses}}{{end}}' $CONTAINER_ID_LIST | sed "s/^\[//g" | awk 'BEGIN {FS="/"} ; {print $1}' > machines_mpi
	
			# session mode
			echo "MULTI_NODE" > .xpn_worksession
		;;

		swarm-stop)
			# get current session mode
			MODE=""
			if [ -f .xpn_worksession ]; then
				MODE=$(cat .xpn_worksession)
			fi

			# Stop composition
			if [ "$MODE" == "SINGLE_NODE" ]; then
				docker-compose -f Dockercompose.yml down
			fi
			# Stop service
			if [ "$MODE" == "MULTI_NODE" ]; then
				docker service rm xpn_node
			fi

			# Remove container cluster files...
			rm -fr machines_mpi
			rm -fr .xpn_worksession
      ./clean_conf.sh
		;;
			 
		swarm-bash)
			# Get parameters
			#CIP=$(head -$1 machines_mpi | tail -1)
			CNAME=$(docker ps -f name=xpn -q | head -1)
			NN=$(wc -l machines_mpi  | awk '{print $1}')
	    
      shift	
   
			# Check parameters
			if [ ! -f machines_mpi ]; then
				echo ": The machines_mpi file was not found."
				echo ": * Please start/swarm-start first."
				echo ": * Please see ./xpn.sh help for more information."
				echo ""
				exit
			fi
			#if [ "x$CIP" == "x" ]; then
			#    echo ": The node ID $1 is out of range (1 up to $NN)."
			#    echo ": * Please see ./xpn.sh help for more information."
			#    echo ""
			#    exit
			#fi
			if [ "x$CNAME" == "x" ]; then
				echo ": There is not a running xpn container."
				echo ": * Please start/swarm-start first."
				echo ": * Please see ./xpn.sh help for more information."
				echo ""
				exit
			fi
		
			docker container exec -it $CNAME /bin/bash $CIP
		;;

		status)
			echo "Show status of current containers..."
			docker ps
		;;

		network)
			echo "Show status of current IPs..."
			CONTAINER_ID_LIST=$(docker ps -f name=node_ -q)
			docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID_LIST
		;;

		cleanup)
			echo "Removing containers and images..."
			docker rm      -f $(docker ps     -a -q)
			docker rmi     -f $(docker images -a -q)
			docker volume rm  $(docker volume ls -q)
			docker network rm $(docker network ls|tail -n+2|awk '{if($2 !~ /bridge|none|host/){ print $1 }}')
		;;

		help)
			echo ""
			echo "  Ubuntu 20.04 on docker (v1.5) "
			echo " -------------------------------"
			echo ""
			echo "  Usage: $0 <action> [<number>]"
			echo ""
			echo "  : Each time u20-dockerfile is update, please execute:"
			echo "       $0 build"
			echo ""
			echo "  : For a typical work session, please execute:"
			echo "       $0 start <number of containers>"
			echo "       $0 status"
			echo "       $0 network"
			echo ""
			echo "       $0 bash <container id, from 1 to number_of_containers>"
			echo "       <some work within container>"
			echo "       exit"
			echo ""
			echo "       $0 stop"
			echo ""
			echo "  : Available option to uninstall u20-docker (remove images + containers):"
			echo "       $0 cleanup"
			echo ""
		;;

		*)
			echo ""
			echo "Unknow command: $1"
			$0 help
		;;
	esac

	shift
done

