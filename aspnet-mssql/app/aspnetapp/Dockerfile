FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS base
WORKDIR /app
FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS build
COPY . /src
WORKDIR /src
RUN dotnet build "aspnetapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "aspnetapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app

RUN apk update \
        && apk add procps \
        net-tools \
        && rm -rf /var/cache/apk/*

ENV APP_USER web_user 
RUN adduser -D $APP_USER
USER $APP_USER

COPY --from=publish /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
