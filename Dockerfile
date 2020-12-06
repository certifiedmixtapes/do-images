# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
#COPY *.sln .
#COPY CMTZ-API/*.csproj ./CMTZ-API/
#COPY RemoteReader/*csproj ./RemoteReader/
#RUN dotnet restore

# copy everything else and build app
COPY . ./
#WORKDIR /source/CMTZ-API
RUN dotnet publish CMTZ-API -c release -o app

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /source/app .
EXPOSE 80
ENTRYPOINT ["dotnet", "DO-Images.dll"]


