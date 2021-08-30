FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build
WORKDIR /src
COPY ["dotnet-docker.csproj", "./"]
RUN dotnet restore "dotnet-docker.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "dotnet-docker.csproj" -c Release -o /app/build
RUN dotnet publish "dotnet-docker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

#A .NET app would usually execute using ENTRYPOINT ["dotnet", "dotnet-docker.dll"]
# But Heroku appears to require you to make the PORT configurable like this
CMD ASPNETCORE_URLS=http://*:$PORT dotnet dotnet-docker.dll
