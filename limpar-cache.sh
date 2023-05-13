#!/bin/bash

echo "Iniciando o script de atualização e limpeza de cache..."

# Baixa atualizações
echo "Baixando atualizações..."
dnf upgrade
if [ $? -eq 0 ]; then
    echo "Atualizações baixadas com sucesso."
else
    echo "Erro ao baixar atualizações. Saindo do script."
    exit 1
fi

# Atualiza os pacotes
echo "Atualizando pacotes..."
dnf update -y
if [ $? -eq 0 ]; then
    echo "Pacotes atualizados com sucesso."
else
    echo "Erro ao atualizar pacotes. Saindo do script."
    exit 1
fi

# Limpa o cache de página
echo "Limpando cache de página..."
sync; echo 1 > /proc/sys/vm/drop_caches
if [ $? -eq 0 ]; then
    echo "Cache de página limpo com sucesso."
else
    echo "Erro ao limpar cache de página. Saindo do script."
    exit 1
fi

# Limpa o cache de dentries e inodes
echo "Limpando cache de dentries e inodes..."
sync; echo 2 > /proc/sys/vm/drop_caches
if [ $? -eq 0 ]; then
    echo "Cache de dentries e inodes limpo com sucesso."
else
    echo "Erro ao limpar cache de dentries e inodes. Saindo do script."
    exit 1
fi

# Limpa o cache de diretórios
echo "Limpando cache de diretórios..."
sync; echo 3 > /proc/sys/vm/drop_caches
if [ $? -eq 0 ]; then
    echo "Cache de diretórios limpo com sucesso."
else
    echo "Erro ao limpar cache de diretórios. Saindo do script."
    exit 1
fi

# Reinicia o sistema
echo "Reiniciando o sistema..."
reboot

