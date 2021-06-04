FROM docker-unj-repo.softplan.com.br/unj-integracoes/ubuntu-delphi-mongo:1.1.0

RUN apt-get update
RUN apt-get install -y curl
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/log
VOLUME ["/usr/src/app/log"]

WORKDIR /usr/src/app

ADD app/ /usr/src/app

# COPY app /usr/src/app/

# RUN chmod +x Server.Ativo
# RUN chmod +x config.txt

# EXPOSE 9000
# CMD [ "./Server.Ativo"]
# database:Server=localhost;Port=3306;Database=crm_sgr;User_Name=root;Password=root;DriverID=MySQL;
