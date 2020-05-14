from clojure:openjdk-11-lein

WORKDIR /tmp

RUN \
apt-get update && \
apt-get install -y jq && \
export CRYOGEN=$(curl -sL https://api.github.com/repos/cryogen-project/cryogen/releases/latest | jq -r '.zipball_url') && \
wget -O cryogen.zip $(echo $CRYOGEN) && \
unzip cryogen.zip && \
rm cryogen.zip && \
mv cryogen* cryogen && \
cd cryogen && \
lein deps && \
cd /opt && \
lein new cryogen gensite && \
cd gensite && \
lein deps && \
rm -rf content src target themes && \
rm *
