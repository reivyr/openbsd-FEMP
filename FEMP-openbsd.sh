#!/bin/sh

set -e

DEP=$(pkg_info -z | grep -E '^(jdk.*1\.8|lwjgl\-\-)' | wc -l)

if [ "$DEP" -eq 2 ]
then
	echo "Dependencies installed"
else
	echo "Dependencies missing. Required packages are jdk, lwjgl"
	exit 1
fi

# Download the latest release of FEMultiPlayer-V2

ftp https://github.com/eliatlarge/FEMultiPlayer-V2/releases/download/v1.7.0/FEMP-v1.7.0.zip

unzip FEMP-v1.7.0.zip

mkdir FEMP-client FEMP-server

# Server

cd FEMP-server

/usr/local/jdk-1.8.0/bin/jar xvf ../FEMP-server.jar

# Client

cd ../FEMP-client

/usr/local/jdk-1.8.0/bin/jar xvf ../FEMP-client.jar
rm -rf org/lwjgl
/usr/local/jdk-1.8.0/bin/jar xvf /usr/local/share/lwjgl/lwjgl.jar

cd ..

# Final Message

echo "Someone needs to create a game first. It uses the port 21255 by default"
echo "cd FEMP-server"
echo "/usr/local/jdk-1.8.0/bin/java net.fe.network.FEServer"
echo "You can start the client with"
echo "cd FEMP-client"
echo "/usr/local/jdk-1.8.0/bin/java -Djava.library.path=/usr/local/share/lwjgl net.fe.FEMultiplayer"
echo "There is a PDF which explains the game mechanics included in the zip."
echo "You can read it with your favorite PDF viewer. For example:"
echo "mupdf Instruction\ Manual.pdf"
