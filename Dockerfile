# Version 1.0.0
FROM ubuntu:16.04

MAINTAINER Victor Chernetsky <victor@amigocloud.com>

RUN apt-get update && apt-get -y install \
	openjdk-8-jdk \
	openjdk-8-jre \
	unzip \
	wget

WORKDIR /home
RUN wget -O corenlp.zip http://nlp.stanford.edu/software/stanford-corenlp-full-2018-02-27.zip
RUN unzip corenlp.zip

ENV port=9000 outputFormat=inlineXML

EXPOSE $port

WORKDIR /home/stanford-corenlp-full-2018-02-27

RUN wget -O stanford-spanish-corenlp-models.jar http://nlp.stanford.edu/software/stanford-spanish-corenlp-2018-02-27-models.jar
#RUN mv -f stanford-spanish-corenlp-models.jar /home/stanford-corenlp-full-2018-02-27

CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer \
    -serverProperties StanfordCoreNLP-spanish.properties
