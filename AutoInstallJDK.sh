#! /bin/bash
# shell script tp install jdk(version:jdk1.8.0_91)
# version 1.0
# created by signalfeng@gmail.com 
# Sat Oct 15 11:46:08 CST 2016

# Step1.Check jdk exists or not !
 
for i in $(rpm -qa | grep jdk | grep -v grep)
do
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Deleting "$i
  rpm -e --nodeps $i
done

# Step2.Feedback if jdk was uninstalled or not !

if [[ -n $(rpm -qa | grep jdk | grep -v grep) ]];
then
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Failed to delete the $i"
  exit 0
else
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Successfully delete $i"
 
  # Step3.Install jdk
     javaPath=/usr/java
     if [[ -n $javaPath ]]
     then
        rm -rf /usr/java
	mkdir /usr/java
	cp jdk-8u91-linux-x64.rpm /usr/java/jdk-8u91-linux-x64.rpm
	if [ $? -eq 0 ]
	then
	   chmod +x jdk-8u91-linux-x64.rpm
	   echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Installing ..."
	   rpm -ivh jdk-8u91-linux-x64.rpm
	   if [ $? -eq 0 ]
	      then
	      echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Successfully Installed jdk-8u91-linux-x64.rpm"
	   else
	      echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Failed to install jdk-8u91-linux-x64.rpm"
	      exit 0
	   fi
	fi
    fi
fi


# Step4.Config jdk-envrionment 

cp /etc/profile /etc/profile.beforeInstallJDKenv.bak

echo "# For jdk1.8.0_91 start" >> /etc/profile
echo "export JAVA_HOME=/usr/java/jdk1.8.0_91" >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
echo "# For jdk1.8.0_91 end " >> /etc/profile

if [ $? -eq 0 ]
then
  source /etc/profile
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] JDK environment has been successed set in /etc/profile."
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] java -version"
  java -version
fi

# Step5.Do a test

cd TestCode

if [ -f HelloWorld.class ]
then
  rm -f HelloWorld.class
fi

javac HelloWorld.java
if [ $? -eq 0 ]
then
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Successfully Complie."
  java HelloWorld
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] When you see 'HelloWorld',it means your JDK-environment was tested successfully."
else
  echo "-->[`date +"%Y-%m-%d %H:%M.%S"`] Failed to complie HelloWorld.java ,maybe your JDK-environment was not installed."
fi

