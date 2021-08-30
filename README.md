# Hello world containerised .NET Core web API app

A reminder of how to create a containerised .NET Core app and deploy it.

For more information see [ASP.NET Core in a container](https://code.visualstudio.com/docs/containers/quickstart-aspnet-core).

Application created using the command `dotnet new webapi`. A `Dockerfile` can be created automatically using the [VSCode Docker extension](https://code.visualstudio.com/docs/containers/quickstart-aspnet-core#_add-docker-files-to-the-project).

## Local usage

```
dotnet run
```

Navigate to https://localhost:5001/WeatherForecast.

## Local Docker usage

```
docker build . -t dotnet-docker
docker run -p 5000:5000 --env PORT=5000 dotnet-docker
```

Navigate to http://localhost:5000/WeatherForecast.

## Running on Google Cloud Run

Pre-requisites:

- A Google Cloud Account with Cloud Run enabled.
- gcloud CLI installed.

For more information see:

- [Pushing and pulling images from Google Container Registry](https://cloud.google.com/container-registry/docs/pushing-and-pulling).
- [Deploying a container to Google Cloud Run](https://cloud.google.com/run/docs/deploying#command-line).

```
PROJECT_ID=your-project-id
gcloud auth login

gcloud config set project $PROJECT_ID

# Build, tag and push the container to Google Container Registry
docker build . -t dotnet-docker
docker tag dotnet-docker eu.gcr.io/$PROJECT_ID/dotnet-docker
docker push eu.gcr.io/$PROJECT_ID/dotnet-docker

# Deploy. All unauthenticated invocations.
gcloud run deploy dotnet-docker --image=eu.gcr.io/$PROJECT_ID/dotnet-docker --project=$PROJECT_ID --platform=managed --region=europe-west1
```

Navigate to [https://serivceurl/weatherforecast].

To delete execute `gcloud run services delete dotnet-docker --platform=managed --project=$PROJECT_ID`.

## Running on Heroku

Pre-requisites:

- A Heroku account.
- Heroku CLI.

For more information see:

- [Container registry and runtime](https://devcenter.heroku.com/articles/container-registry-and-runtime).
- [Heroku CLI documentation](https://devcenter.heroku.com/articles/heroku-cli-commands).

```
heroku login

heroku container:login

heroku create

heroku container:push web

heroku container:release web

heroku open
```

Navigate to [https://serivceurl/weatherforecast].

To delete execute `heroku apps:destroy`.
