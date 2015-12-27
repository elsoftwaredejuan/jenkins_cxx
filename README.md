# Jenkins Docker image with C++ Stuff 
This is a fully functional Jenkins server, based on the Long Term Support release [http://jenkins-ci.org/](http://jenkins-ci.org/), with all elements necessary for compiling and testing c++ code.

![logo](http://jenkins-ci.org/sites/default/files/jenkins_logo.png)
<img src="https://cmsresources.windowsphone.com/devcenter/common/resources/images/games/tech/CPlusPlus.png" width="108">

# How to use this image
```console
docker run -p 8080:8080 -p 50000:50000 -p 443:443 -i -t jenkins_cxx
```
This will store the workspace in /var/jenkins_home. All Jenkins data lives in there - including plugins and configuration. You will probably want to make that a persistent volume (recommended):

```console
docker run -p 8080:8080 -p 50000:50000 -p 443:443 -v /your/home:/var/jenkins_home -i -t jenkins
```
<a href="https://github.com/docker-library/docs/blob/master/jenkins/README.md" target="_blank">... more info</a>

# C++ Stuff
 * Compiler: <a href="http://clang.llvm.org" target="_blank">clang</a>
 * Compiling orchestration: <a href="https://cmake.org/documentation/" target="_blank">cmake</a>
 * Static analysis: <a href="http://cppcheck.sourceforge.net" target="_blank">cppcheck</a>
 * Testing: <a href="https://github.com/google/googletest" target="_blank">google test</a>
 
# Extra Stuff
 * setup-google-test.xml: Jenkins job for compiling and installing google test.
 * compile-hello-world.xml: Jenkins' job for testing all c++ infrastructure and for showing some tips for how to use all this stuff.
 
