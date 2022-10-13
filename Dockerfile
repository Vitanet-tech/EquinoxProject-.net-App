# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY src/Equinox.Application/*.csproj ./EquinoxProject/
RUN dotnet restore "src/Equinox.Application/Equinox.Application.csproj"

# copy everything else and build app
COPY EquinoxProject-.net-App/. ./EquinoxProject/
WORKDIR /source/aspnetapp
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "EquinoxProject.dll"]
