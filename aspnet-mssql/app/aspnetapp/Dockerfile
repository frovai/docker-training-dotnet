FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
COPY . /src
WORKDIR /src
RUN dotnet build "aspnetapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "aspnetapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app

RUN apt update -y 
RUN apt-get install --reinstall procps net-tools -y

COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
