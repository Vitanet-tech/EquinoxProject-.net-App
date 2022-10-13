# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY src/Equinox.Application/*.csproj ./
RUN dotnet restore "*.csproj"

# copy everything else and build app
COPY . .
RUN dotnet publish -c release -o out

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /source
COPY --from=build /source ./
ENTRYPOINT ["dotnet", "EquinoxProject.dll"]
