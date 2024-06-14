![Static Badge](https://img.shields.io/badge/API_version-0.4.0.6-blue) ![Static Badge](https://img.shields.io/badge/Fooocus_version-2.3.1-blue) ![Static Badge](https://img.shields.io/badge/API_coverage-100%25-vividgreen) ![Static Badge](https://img.shields.io/badge/API_tests-passed-vividgreen)

[Fooocus-API](https://github.com/mrhan1993/Fooocus-API) RunPod serverless worker implementation with anime settings.
___
The **Standalone** branch is a ready-to-use docker image with all the files and models already baked and installed into it. You can still customize it to use your own content, but it can't be changed without rebuilding and redeploying the image. This is ideal if you want the fastest, cheapest possible endpoint for long-term usage without the need for frequent changes of its contents. See [standalone-guide](https://github.com/neurowhai/RunPod-Fooocus-API/blob/Standalone/docs/standalone-guide.md) or simply use `neurowhai/runpod-fooocus-anime-api:0.4.0.6-standalone` as the image for a quick deploy with the default Juggernaut V8 on your RunPod serverless endpoint.

## How to send requests
[request_examples.js](https://github.com/davefojtik/RunPod-Fooocus-API/blob/Standalone/docs/request_examples.js) contain example payloads for all endpoints on your serverless worker, regardless of the branch. But don't hesitate to ask if you need more help.

## Contributors Welcomed
Feel free to make pull requests, fixes, improvements and suggestions to the code. Any cooperation on keeping this repo up-to-date and free of bugs is highly welcomed.

## Updates
We're not always on the latest version automatically, as there can be breaking changes or major bugs. The updates are being made only after thorough tests by our community of Discord users generating images with the AI agent using this repo as it's tool. And only if we see that the new version performs better and stable.
___
> *Disclaimer: This repo is in no way affiliated with RunPod Inc. All logos and names are owned by the authors. This is an unofficial community implementation*
