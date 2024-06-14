# ---------------------------------------------------------------------------- #
#                         Part 1: Download the files                           #
# ---------------------------------------------------------------------------- #
FROM alpine/git:2.43.0 as download

# Clone the repos
# Fooocus-API
RUN set -Eeuox pipefail && \
    mkdir -p /workspace && \
    cd /workspace && \
    git init && \
    git remote add origin https://github.com/mrhan1993/Fooocus-API.git && \
    git fetch origin a50ed2f7db116f49e168c634ce4fa639ca42dda7 --depth=1 && \
    git reset --hard a50ed2f7db116f49e168c634ce4fa639ca42dda7

# ---------------------------------------------------------------------------- #
#                        Part 2: Build the final image                         #
# ---------------------------------------------------------------------------- #
FROM python:3.10.14-slim as build_final_image
ENV DEBIAN_FRONTEND=noninteractive \
    PIP_PREFER_BINARY=1 \
    PYTHONUNBUFFERED=1
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Update and upgrade the system packages
RUN apt-get update && \
    apt install -y \
    fonts-dejavu-core rsync git jq moreutils aria2 wget libgoogle-perftools-dev procps libgl1 libglib2.0-0 && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && apt-get clean -y

RUN --mount=type=cache,target=/cache --mount=type=cache,target=/root/.cache/pip \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Copy downloaded data to the final image
COPY --from=download /workspace/ /workspace/
# Change Fooocus configs
COPY src/default.json /workspace/repositories/Fooocus/presets/default.json
ADD src .

# Install Python dependencies
COPY builder/requirements.txt /requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --upgrade pip && \
    pip install --upgrade -r /requirements.txt --no-cache-dir && \
    rm /requirements.txt

ADD src .

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------------- #
#                              Download models                                 #
# ---------------------------------------------------------------------------- #

RUN wget -O /workspace/repositories/Fooocus/models/checkpoints/animaPencilXL_v400.safetensors https://huggingface.co/mashb1t/fav_models/resolve/main/fav/animaPencilXL_v400.safetensors?download=true
RUN wget -O /workspace/repositories/Fooocus/models/loras/sd_xl_offset_example-lora_1.0.safetensors https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_offset_example-lora_1.0.safetensors?download=true
RUN wget -O /workspace/repositories/Fooocus/models/loras/sdxl_lcm_lora.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/sdxl_lcm_lora.safetensors?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/loras/sdxl_lightning_4step_lora.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/sdxl_lightning_4step_lora.safetensors?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/inpaint/fooocus_inpaint_head.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/fooocus_inpaint_head.pth?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/inpaint/inpaint.fooocus.patch https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/inpaint.fooocus.patch?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/inpaint/inpaint_v25.fooocus.patch https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/inpaint_v25.fooocus.patch?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/inpaint/inpaint_v26.fooocus.patch https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/inpaint_v26.fooocus.patch?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/control-lora-canny-rank128.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/control-lora-canny-rank128.safetensors?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/fooocus_xl_cpds_128.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/fooocus_xl_cpds_128.safetensors?download=true
RUN wget -O /workspace/repositories/Fooocus/models/controlnet/fooocus_ip_negative.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/fooocus_ip_negative.safetensors?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/ip-adapter-plus_sdxl_vit-h.bin https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/ip-adapter-plus_sdxl_vit-h.bin?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/ip-adapter-plus-face_sdxl_vit-h.bin https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/ip-adapter-plus-face_sdxl_vit-h.bin?download=true
RUN wget -O /workspace/repositories/Fooocus/models/upscale_models/fooocus_upscaler_s409985e5.bin https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/fooocus_upscaler_s409985e5.bin?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/clip_vision/clip_vision_vit_h.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/clip_vision_vit_h.safetensors?download=true
RUN wget -O /workspace/repositories/Fooocus/models/vae_approx/xlvaeapp.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/xlvaeapp.pth?download=true
RUN wget -O /workspace/repositories/Fooocus/models/vae_approx/vaeapp_sd15.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/vaeapp_sd15.pt?download=true
RUN wget -O /workspace/repositories/Fooocus/models/vae_approx/xl-to-v1_interposer-v3.1.safetensors https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/xl-to-v1_interposer-v3.1.safetensors?download=true
RUN wget -O /workspace/repositories/Fooocus/models/prompt_expansion/fooocus_expansion/pytorch_model.bin https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/fooocus_expansion.bin?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/detection_Resnet50_Final.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/detection_Resnet50_Final.pth?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/detection_mobilenet0.25_Final.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/detection_mobilenet0.25_Final.pth?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/parsing_parsenet.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/parsing_parsenet.pth?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/controlnet/parsing_bisenet.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/parsing_bisenet.pth?download=true
# RUN wget -O /workspace/repositories/Fooocus/models/clip_vision/model_base_caption_capfilt_large.pth https://huggingface.co/3WaD/RunPod-Fooocus-API/resolve/main/v0.3.30/model_base_caption_capfilt_large.pth?download=true

RUN chmod +x /start.sh
CMD /start.sh
