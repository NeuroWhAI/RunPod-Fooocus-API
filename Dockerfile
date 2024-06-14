FROM 3wad/runpod-fooocus-api:0.4.0.6-standalone

# Change Fooocus configs
COPY src/default.json /workspace/repositories/Fooocus/presets/default.json
ADD src .

# Remove default checkpoints
RUN rm /workspace/repositories/Fooocus/models/checkpoints/juggernautXL_v8Rundiffusion.safetensors

RUN wget -O /workspace/repositories/Fooocus/models/checkpoints/animaPencilXL_v310.safetensors https://huggingface.co/mashb1t/fav_models/resolve/main/fav/animaPencilXL_v310.safetensors?download=true

CMD /start.sh