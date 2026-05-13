FROM mcr.microsoft.com/appsvc/staticappsclient:stable@sha256:51fe406435889083d913524cb93f01868dccacf9deb458e5be0c31e6ff3fc392
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]