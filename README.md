# XPN on Docker v2.2 (with Ubuntu 22.04 LTS)

## Contents

 * [Getting xpn-docker](https://github.com/acaldero/xpn-docker/#getting-xpn-docker)
 * [Some use cases with lab-docker](https://github.com/acaldero/xpn-docker/#examples-of-some-use-cases-with-lab-docker)
 * [Using lab-docker](https://github.com/acaldero/xpn-docker/#using-lab-docker)


## Getting xpn-docker

```
git clone https://github.com/acaldero/xpn-docker.git
cd xpn-docker
./lab.sh build
```

## Examples of some use cases with lab-docker

<html>
 <table>

  <tr>
  <td>
Example
  </td>
  <td>
(1) To start <b>3</b> containers:
  </td>
  <td>
(2) To run the example:
  </td>
  <td>
(3) To stop the containers:
  </td>
  </tr>

  <tr>
  <td>
Expand (native)
  </td>
  <td>
   <pre>
./lab.sh start <b>3</b>
./lab.sh status
   </pre>
  </td>
  <td>
   <pre>
./lab.sh bash <b>1</b>
source .profile
<b>./data/xpn-mpi-native.sh</b>
exit
   </pre>
  </td>
  <td>
   <pre>
./lab.sh stop
   </pre>
  </td>
  </tr>

  <tr>
  <td>
Expand (bypass)
  </td>
  <td>
   <pre>
./lab.sh start <b>3</b>
./lab.sh status
   </pre>
  </td>
  <td>
   <pre>
./lab.sh bash <b>1</b>
source .profile
<b>./data/xpn-mpi-bypass.sh</b>
exit
   </pre>
  </td>
  <td>
   <pre>
./lab.sh stop
   </pre>
  </td>
  </tr>

  <tr>
  <td>
Expand (fuse)
  </td>
  <td>
   <pre>
./lab.sh start <b>3</b>
./lab.sh status
   </pre>
  </td>
  <td>
   <pre>
./lab.sh bash <b>1</b>
source .profile
<b>./data/xpn-mpi-fuse.sh</b>
exit
   </pre>
  </td>
  <td>
   <pre>
./lab.sh stop
   </pre>
  </td>
  </tr>

 </table>
</html>


## Using lab-docker

<html>
 <table>
  <tr>
  <th>Action</th>
  <th>Command</th>
  </tr>

  <tr>
  <td> First time + "each time docker/dockerfile is updated"  </td>
  <td><pre>./lab.sh build</pre>
  </td>
  </tr>

  <tr>
  <td> To start a work session with <b>3</b> containers </td>
  <td><pre>./lab.sh start <b>3</b></pre>
  </td>
  </tr>

  <tr>
  <td> To get into container <b>1</b>  </td>
  <td><pre> ./lab.sh bash <b>1</b></pre>
  </td>
  </tr>

  <tr>
  <td> Being in container <b>1</b>, to exit  </td>
  <td>   <pre>exit</pre>  </td>
  </tr>

  <tr>
  <td>To stop the work session please use  </td>
  <td><pre>./lab.sh stop</pre>
  </td>
  </tr>

  <tr>
  <td>
</html>

  * Available options for debugging:
    * To check running containers:
    * To get the containers internal IP addresses:
  
<html>
  </td>
  <td>
</html>

  * Available options for debugging:
    * ./lab.sh status
    * ./lab.sh network

<html>
  </td>
  </tr>
 </table>
</html>

**Please beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".
  * You might need to use "sudo" before ./lab.sh if your user doesn't belong to the docker group
    * could be solved by using "sudo usermod -aG docker ${USER}"


## Authors
* :technologist: Félix García-Carballeira
* :technologist: Alejandro Calderón Mateos
* :technologist: Diego Camarmas Alonso (XPN)
* :technologist: Elias del Pozo Puñal (XPN)


