# Get base image from docker hub
FROM mcr.microsoft.com/dotnet/sdk:5.0 as build-env
WORKDIR /app
# Copy .csproj and restore the nugts
COPY *.csproj ./
# Copy everything else 
COPY . ./
RUN dotnet publish -c release -o /app/publish

#creating our publish image from the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
COPY --from=build-env /app/publish .
EXPOSE 80
ENTRYPOINT [ "dotnet", "dotnet.dll" ]