FROM caffeinatedexpert/docker-oracle7-slim-java8:latest

ENV COH_INSTALLER fmw_12.2.1.3.0_coherence.jar

RUN mkdir /u01 && chmod a+xr /u01 && \
    useradd -b /u01 -m -s /bin/bash oracle && \
    echo oracle:oracle | chpasswd && \
    chown oracle /u01 && \
    mkdir /home/oracle && \
    chown oracle /home/oracle

RUN curl -o /u01/$COH_INSTALLER https://storage.googleapis.com/gcp-gdis-tools/public/downloads/$COH_INSTALLER
COPY coh.rsp /u01/
COPY oraInst.loc /u01/oraInst.loc

RUN chown oracle /u01/$COH_INSTALLER \
 && chown oracle /u01/coh.rsp \
 && chown oracle /u01/oraInst.loc

ENV COHERENCE_HOME=/u01/app/oracle/coherence/coherence

USER oracle

#RUN java -jar /u01/$COH_INSTALLER -silent -force -responseFile /u01/coh.rsp -invPtrLoc /u01/oraInst.loc -jreLoc $JAVA_HOME \
#  && rm /u01/$COH_INSTALLER \
#  && rm /u01/coh.rsp \
#  && rm /u01/oraInst.loc \
#  && rm -rf /tmp/OraInstall*