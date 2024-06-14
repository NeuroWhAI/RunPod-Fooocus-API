## How to use standalone image
- [**Create RunPod serverless endpoint:**](https://www.runpod.io/console/serverless) use `3wad/runpod-fooocus-api:0.4.0.6-standalone`
- Other settings are your choice, but I personally found that using 4090/L4 GPUs + Flashboot is the most cost-effective one.
- That's it! See the [request_examples](https://github.com/davefojtik/RunPod-Fooocus-API/blob/Standalone/docs/request_examples.js) for how to make requests to this endpoint from your app.

## How to customize standalone image
To modify default settings and model, see [anime.json](https://github.com/NeuroWhAI/RunPod-Fooocus-API/blob/Standalone/src/anime.json)  
To modify which models and files are being baked into the image, see [Dockerfile](https://github.com/davefojtik/RunPod-Fooocus-API/blob/Standalone/Dockerfile)