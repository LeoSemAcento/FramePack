# Define a imagem base. Usamos uma imagem oficial do Python
# que é mais leve (slim) e geralmente compatível.
# Se você precisar de GPU no futuro, a imagem base pode precisar ser diferente.
FROM python:3.10-slim

# Instala pacotes de sistema necessários.
# 'apt-get update' atualiza a lista de pacotes disponíveis.
# 'apt-get install -y ffmpeg' instala o ffmpeg (o -y aceita automaticamente a instalação).
# 'rm -rf /var/lib/apt/lists/*' limpa o cache do apt para reduzir o tamanho da imagem final.
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do contêiner.
# Todos os comandos seguintes serão executados a partir deste diretório.
WORKDIR /app

# Copia todos os arquivos do seu repositório local para o diretório /app no contêiner.
COPY . /app

# Instala as dependências do Python listadas no requirements.txt.
# '--no-cache-dir' ajuda a manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Define o comando padrão que será executado quando o contêiner iniciar.
# Você precisará ajustar este comando para como o FramePack é iniciado.
# Exemplo: Se houver um script 'run.py', o comando seria:
# CMD ["python", "run.py"]
# Ou se for outro comando, substitua por ele.
# Por enquanto, vamos colocar um placeholder que você precisará ajustar.
# Você precisará descobrir qual comando inicia a aplicação FramePack.
CMD ["python", "sua_aplicacao_principal.py"] # <-- SUBSTITUA "sua_aplicacao_principal.py" pelo arquivo/comando correto

# Opcional: Se sua aplicação FramePack roda um servidor web em uma porta específica,
# você pode expor essa porta. Ex: EXPOSE 8000 (se roda na porta 8000).
# Verifique a documentação do FramePack ou o código para saber se e qual porta ele usa.
