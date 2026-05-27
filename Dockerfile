FROM mcr.microsoft.com/appsvc/staticappsclient:stable@sha256:8ed8ea489d04d0636b5c47fbaa44f005975ab0d1f03eddc28014cdf7a061f7f4
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]