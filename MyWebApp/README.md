# ASP.NET Core Docker for Homework2 - Docker Training course.

# Prerequisites
To have APP.NET Core app on your machine according to requeriments in homework-2, this app should have been build and published.

# Create a Dockerfile for an ASP.NET Core application
1. Create a Dockerfile in your project folder
2. Add the text below to your Dockerfile:

```console
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY out/* /app/out/

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
```
# Build and run the Docker image
1. Open a command prompt and navigate to your project folder.
2. Use the following commands to build and run your Docker image:

```console
docker build -t mywebapp:0.1 .
docker run -d -p 5217:80 --name homework2 mywebapp:0.1
```
# Publish the Docker image
1. Login to docker hub with your credentials:

```console
docker login -u jmgutierrez22
password:
```
2. Create a new tag for you image:

```console
docker tag mywebapp:0.1 jmgutierrez22/docker_training:marcelo.gutierrez
```
3. Push the image:

```console
docker push jmgutierrez22/docker_training:marcelo.gutierrez
```
4. If no errors, make sure your image has been uploaded.


