FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# # Install Bash
# RUN apk update
# RUN apk upgrade
# RUN apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib wget tar

# RUN wget -O ./dotnet-sdk-3.1.404-linux-musl-x64.tar.gz https://download.visualstudio.microsoft.com/download/pr/d7b82e76-1d88-4873-817b-2c3f02c93138/92137dd72c4a1ae2e758edbe95756068/dotnet-sdk-3.1.404-linux-musl-x64.tar.gz
# RUN mkdir -p "${HOME}/dotnet" && tar zxf ./dotnet-sdk-3.1.404-linux-musl-x64.tar.gz -C "${HOME}/dotnet"
# ENV DOTNET_ROOT="${HOME}/dotnet"
# ENV PATH="${PATH}:${HOME}/dotnet"


# Install npm
RUN apt-get update -yq 
RUN apt-get install curl gnupg -yq 
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs
# RUN apt-get install -yq npm

# Set up installs
COPY ./ /DotnetApplication

WORKDIR /DotnetApplication
RUN dotnet build

WORKDIR /DotnetApplication/DotnetTemplate.Web
RUN npm install
RUN npm run build

EXPOSE 5000
ENTRYPOINT [ "dotnet", "run" ]