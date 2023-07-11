#!/bin/bash
FROM registry.access.redhat.com/ubi9/ubi
MAINTAINER nobody@redhat.com
RUN mkdir /opt/incoming  
RUN mkdir /opt/outgoing
RUN echo "while true"  >> /usr/local/bin/ascii2pdf
RUN echo "do"  >> /usr/local/bin/ascii2pdf
RUN echo "CURRENT_DIR='/opt/incoming'"  >> /usr/local/bin/ascii2pdf
RUN echo "#app=#(ls -Art1 datas | tail -n 1)"  >> /usr/local/bin/ascii2pdf
RUN echo "text1 "  >> /usr/local/bin/ascii2pdf
RUN echo "enscript /opt/incoming/-o - | ps2pdf - /opt/outgoing/.txt"  >> /usr/local/bin/ascii2pdf
RUN echo "done"  >> /usr/local/bin/ascii2pdf
RUN sed -i 's/text1/echo $FILE/g' /usr/local/bin/ascii2pdf
RUN sed -i 's/-o/$FILE  -o/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/.txt/$FILE/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/#app=#/FILE=$/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/datas/${CURRENT_DIR}/g'  /usr/local/bin/ascii2pdf
RUN chmod 777 /usr/local/bin/ascii2pdf 
RUN yum install --skip-broken -y http://content/rhel9.0/x86_64/dvd/AppStream/Packages/enscript-1.6.6-28.el9.x86_64.rpm  http://content/rhel9.0/x86_64/dvd/AppStream/Packages/ghostscript-9.54.0-7.el9.x86_64.rpm 
CMD [ "/bin/bash", "-c", "/usr/local/bin/ascii2pdf" ]
