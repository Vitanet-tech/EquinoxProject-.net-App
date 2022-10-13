FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app
COPY src/Equinox.Application/Equinox.Application.csproj ./
RUN dotnet restore
COPY . ./
RUN dotnet build "Equinox.Application.csproj" -c Release -o /app
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "Equinox-Application.dll"]
