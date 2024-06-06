# Expand Docker (v3.0.0)

## Contents

 * [Some use cases with xpn-docker](https://github.com/xpn-arcos/xpn-docker/#some-use-cases-with-xpn-docker)
 * [Using xpn-docker](https://github.com/xpn-arcos/xpn-docker/#using-xpn-docker)


## Some use cases with xpn-docker

<html>
 <table>

  <tr>
  <td>
Examples
  </td>
  <td>
Step 1: <br> To start <b>3</b> containers
  </td>
  <td>
Step 2: <br> Some work from container <b>1</b>
  </td>
  <td>
Step 3: <br> To stop the containers
  </td>
  </tr>


  <tr>
  <td>
Expand (bypass)
  </td>
  <td>
   <code>./xpn_docker.sh start <b>3</b>
./xpn_docker.sh status</code>
  </td>
  <td>
   <code>./xpn_docker.sh bash <b>1</b>
<b>./data/xpn-mpi-bypass.sh</b>
exit</code>
  </td>
  <td>
   <code>./xpn_docker.sh stop</code>
  </td>
  </tr>

  
  <tr>
  <td>
Expand (native)
  </td>
  <td>
   <code>./xpn_docker.sh start <b>3</b>
./xpn_docker.sh status</code>
  </td>
  <td>
   <code>./xpn_docker.sh bash <b>1</b>
<b>./data/xpn-mpi-native.sh</b>
exit</code>
  </td>
  <td>
  <code>./xpn_docker.sh stop</code>
  </td>
  </tr>
  

  <tr>
  <td>
Expand (fuse)
  </td>
  <td>
   <code>./xpn_docker.sh start <b>3</b>
./xpn_docker.sh status</code>
  </td>
  <td>
   <code>./xpn_docker.sh bash <b>1</b>
<b>./data/xpn-mpi-fuse.sh</b>
exit</code>
  </td>
  <td>
   <code>./xpn_docker.sh stop</code>
  </td>
  </tr>


  <tr>
  <td>
Apache Spark
  </td>
  <td>
   <code>./xpn_docker.sh start <b>3</b>
./xpn_docker.sh status   </code>
  </td>
  <td>
   <code>./xpn_docker.sh bash <b>1</b>
<b>./spark/quixote-local.sh</b>
exit</code>
  </td>
  <td>
   <code>./xpn_docker.sh stop</code>
  </td>
  </tr>

 </table>
</html>


## Using xpn-docker

<html>
 <table>
  <tr>
  <th colspan="2">Action</th>
  <th>Command</th>
  </tr>

  <tr>
  <td colspan="2"> First time + "each time ./docker/dockerfile is updated"  </td>
  <td><code>./xpn_docker.sh build</code>
  </td>
  </tr>

  <tr>
  <td rowspan="4">
  Work session
  </td>
  <td colspan="1"> To spin up <b>3</b> containers </td>
  <td><code>./xpn_docker.sh start <b>3</b></code>
  </td>
  </tr>

  <tr>
  <td colspan="1"> To get into container <b>1</b>  </td>
  <td><code> ./xpn_docker.sh bash <b>1</b></code>
  </td>
  </tr>

  <tr>
  <td colspan="1"> To exit from container </td>
  <td><code>exit</code>  </td>
  </tr>

  <tr>
  <td colspan="1"> To spin down all containers </td>
  <td><code>./xpn_docker.sh stop</code>
  </td>
  </tr>

  <tr>
  <td rowspan="2">
  Options for debugging
  </td>
  <td>  
  To check running containers
  </td>
  <td>
  <code>./xpn_docker.sh status</code>
  </td>
  </tr>

  <tr>
  <td>  
  To get the containers internal IP addresses
  </td>
  <td>
  <code>./xpn_docker.sh network</code>
  </td>
  </tr>
 
 </table>
</html>

**Please beware of**:
  * Any modification outside the "/work" directory will be discarded on container stopping.
  * Please make a backup of your work "frequently" (just in case).
  * You might need to use "sudo" before ./xpn_docker.sh if your user doesn't belong to the docker group
    * It could be solved by using "sudo usermod -aG docker ${USER}"


## Authors
* :technologist: Félix García-Carballeira
* :technologist: Alejandro Calderón Mateos
* :technologist: Diego Camarmas Alonso
* :technologist: Dario Muñoz Muñoz
* :technologist: Elias del Pozo Puñal

