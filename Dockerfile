# Define a imagem base. Usamos uma imagem oficial do Python
# que é mais leve (slim) e geralmente compatível.
# Se você precisar de GPU no futuro, a imagem base pode precisar ser diferente.
FROM python:3.10-slim

# Instala dependências de sistema (como ffmpeg)
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia todos os arquivos do seu projeto local para o diretório /app no contêiner.
COPY . /app

# Instala as dependências principais do PyTorch explicitamente, como recomendado no README.
# Isso ajuda a garantir que as versões corretas com suporte a CUDA sejam instaladas primeiro.
# A URL específica (cu126) é para CUDA 12.6, que pode ser relevante dependendo da imagem base e GPU disponível no Render.
# Se você não tiver certeza sobre a versão CUDA na imagem base ou Render, pode tentar uma URL mais genérica ou omitir o --index-url inicialmente,
# mas a versão CUDA é crucial para o desempenho da GPU. Vamos usar a do README por enquanto.
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

# Instala as demais dependências do Python a partir do requirements.txt.
# Note: Torch, torchvision, e torchaudio já estarão instalados se a linha acima funcionar,
# mas pip install -r requirements.txt garantirá que outras dependências estejam presentes.
RUN pip install --no-cache-dir -r requirements.txt

# Define o comando padrão que será executado quando o contêiner iniciar.
# Manteremos este comando aqui, embora o "Docker Command" no Render o sobrescreva,
# para manter o Dockerfile auto-contido.
CMD ["python", "demo_gradio.py"]

# Opcional: Como é uma interface Gradio (GUI), ela geralmente roda em uma porta.
# A porta padrão do Gradio é 7860. É uma boa prática expor essa porta.
EXPOSE 7860
