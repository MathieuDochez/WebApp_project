FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./WebApplication1/WebApplication1.cdproj" --disable-parallel
RUN dotnet publish "./WebApplication1/WebApplication1.csproj" -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5258

ENTRYPOINT ["dotnet", "WebApplication1.dll"]