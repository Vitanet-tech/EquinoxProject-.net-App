FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app
# Copy csproj and restore as distinct layers
COPY *.sln ./
RUN dotnet restore
# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out
# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
