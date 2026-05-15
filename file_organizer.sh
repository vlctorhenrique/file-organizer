#!/bin/bash
# ============================================
#file-organizer: Organiza arquivos por tipo
#Autor: Victor
# ============================================

# Pasta a organizar (padrão: pasta atual)
TARGET="${1:-.}"

echo "📁 Organizando arquivos em: $TARGET"

# Contadores
moved=0
skipped=0

# Pervorre todos os arquivos da pasta
for file in "$TARGET"/*; do

  #ignora se não for arquivo
  [ -f "$file" ] || continue
  # Pega a extensão em minúsculo
  ext="${file##*.}"
  ext="${ext,,}"
  
  # Define a subpasta por tipo
  case "$ext" in
    jpg|jpeg|png|gif|svg|webp) folder="images" ;;
    mp4|avi|mkv|mov)           folder="videos" ;;
    mp3|wav|ogg|flac)          folder="audio" ;;
    pdf|doc|docx|txt|odt)      folder="documents" ;;
    zip|tar|gz|rar|7z)         folder="archives" ;;
    sh|py|js|ts|html|css)      folder="code" ;;
    *)                         folder="others" ;;
  esac

  # Cria a subpasta se não existir
  mkdir -p "$TARGET/$folder"

  # Move o arquivo
  mv "$file" "$TARGET/$folder/"
  echo " ✅ $file → $folder/"
  ((moved++))

done

echo ""
echo "✔  Concluído! $moved arquivo(s) organizado(s)." 
